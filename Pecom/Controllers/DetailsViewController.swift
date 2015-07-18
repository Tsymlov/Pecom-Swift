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

class DetailsViewController: UIViewController {
    
    //MARK: - Properties

    @IBOutlet weak var backButton: UIButton!
    var orderNumber: String!
    
    //MARK: - View life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkOrder()
        configureBackButton()
    }
    
    //Order number for testing is АРМВКОИ-12/2303
    private func checkOrder(){
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["Authorization": "Basic SXZhbkRyYWdvOjg4RTI2OTEyQzkyQ0E4RDNGNkREQkY4OUU5QUMyQ0EzQjg2QTM0M0Y="]
        Alamofire.request(.POST, "https://kabinet.pecom.ru/api/v1/cargos/basicstatus/", parameters: ["cargoCodes": [orderNumber]], encoding: ParameterEncoding.JSON)
            .responseJSON { (_, _, JSON, _) in
                println(JSON)
        }
//        get(path, parameters: ["cargoCodes": [orderNumber]], delegate: nil)
    }
    
    let hostname = "https://kabinet.pecom.ru"
    let path = "/api/v1/cargos/basicstatus/"
    
    func get(path: String, parameters: [String: AnyObject]? = nil, delegate: APIProtocol? = nil){
        let url = "\(self.hostname)\(path)"
        NSLog("Preparing for GET request to: \(url)")
        
        Alamofire.request(.GET, url, parameters: parameters, encoding: ParameterEncoding.JSON)
            .responseJSON { (req, res, json, error) in
                if(error != nil) {
                    NSLog("GET Error: \(error)")
                    println(res)
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
}

//MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(DetailsTableViewCell.reuseID) as! DetailsTableViewCell
        
        switch indexPath.row{
            //TODO:
        default:
            break
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension DetailsViewController: UITableViewDelegate{
    
}

protocol APIProtocol {
    func didReceiveResult(results: JSON)
}
