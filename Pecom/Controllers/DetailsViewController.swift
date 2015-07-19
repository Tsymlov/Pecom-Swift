//
//  DetailsViewController.swift
//  Pecom
//
//  Created by Alexey Tsymlov on 7/9/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

protocol APIProtocol {
    func didReceiveResult(results: JSON)
}


class DetailsViewController: UIViewController {
    
    //MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    var refreshControl: UIRefreshControl!
    var orderNumber: String!
    var cargoDetails: CargoDetails!
    var items: [String: String]!
    
    //MARK: - View life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeRefreshControl()
        refreshControl.beginRefreshing()
        checkOrder()
        configureBackButton()
    }
    
    private func initializeRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    //Order number for testing is АРМВКОИ-12/2303
    private func checkOrder(){
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["Authorization": "Basic SXZhbkRyYWdvOjg4RTI2OTEyQzkyQ0E4RDNGNkREQkY4OUU5QUMyQ0EzQjg2QTM0M0Y="]
//        Alamofire.request(.POST, "https://kabinet.pecom.ru/api/v1/cargos/basicstatus/", parameters: ["cargoCodes": [orderNumber]], encoding: ParameterEncoding.JSON)
//            .responseJSON { (_, _, JSON, _) in
//                println(JSON)
//        }
        get(path, parameters: ["cargoCodes": [orderNumber]], delegate: self)
    }
    
    let hostname = "https://kabinet.pecom.ru"
    let path = "/api/v1/cargos/basicstatus/"
    
    func get(path: String, parameters: [String: AnyObject]? = nil, delegate: APIProtocol? = nil){
        let url = "\(self.hostname)\(path)"
        println("Preparing for GET request to: \(url)")
        Alamofire.request(.GET, url, parameters: parameters, encoding: ParameterEncoding.JSON)
            .responseJSON { (req, res, json, error) in
                if(error != nil) {
                    println("GET Error: \(error)")
                    println(res)
                    self.showAlertAndGoToCheckScreen(error?.localizedDescription ?? "")
                }
                else {
                    var json = JSON(json!)
                    NSLog("GET Result: \(json)")
                    
                    // Call delegate if it was passed into the call
                    if(delegate != nil) {
                        delegate!.didReceiveResult(json)
                    }
                }
        }
    }
    
    private func showAlertAndGoToCheckScreen(message: String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ок", style: UIAlertActionStyle.Cancel) { _ in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    private func configureBackButton(){
        backButton.layer.cornerRadius = 4
        backButton.layer.masksToBounds = true
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = backButton.tintColor?.CGColor
    }
    
    //MARK: - Actions
    
    @IBAction func backButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func refresh(){
        //do nothing
    }
}

//MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(DetailsTableViewCell.reuseID) as! DetailsTableViewCell
        
        switch indexPath.row{
        case 1:
            cell.title.text = "arrivalDateTime"
            cell.detail.text = cargoDetails.arrivalDateTimeString
        case 2:
            cell.title.text = "arrivalDateTime"
            cell.detail.text = cargoDetails.arrivalDateTimeString
        case 3:
            cell.title.text = "cargoStatus"
            cell.detail.text = cargoDetails.cargoStatus
        case 4:
            cell.title.text = "giveOutDateTime"
            cell.detail.text = cargoDetails.giveOutDateTimeString
        case 5:
            cell.title.text = "sendingDateTime"
            cell.detail.text = cargoDetails.sendingDateTimeString
        case 6:
            cell.title.text = "takeOnStockDateTime"
            cell.detail.text = cargoDetails.takeOnStockDateTimeString
        default:
            break
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension DetailsViewController: UITableViewDelegate{
}

//MARK: - APIProtocol
extension DetailsViewController: APIProtocol{
    func didReceiveResult(results: JSON) {
        
        println("Details.didReceiveResult: \(results)")
        
        for (index: String, details: JSON) in results {
            var cargoDetails = CargoDetails()
            cargoDetails.arrivalDateTimeString = details["arrivalDateTime"].stringValue
            cargoDetails.arrivalPlanDateTimeString = details["arrivalPlanDateTime"].stringValue
            cargoDetails.cargoStatus = details["cargoStatus"].string
            cargoDetails.giveOutDateTimeString = details["giveOutDateTimeString"].string
            cargoDetails.sendingDateTimeString = details["sendingDateTimeString"].string
            cargoDetails.takeOnStockDateTimeString = details["takeOnStockDateTimeString"].string
        }
        
        // Make sure we are on the main thread, and update the UI.
        dispatch_sync(dispatch_get_main_queue(), {
            self.refreshControl!.endRefreshing()
            self.tableView.reloadData()
        })
    }
}

