//
//  DetailsViewController.swift
//  Pecom
//
//  Created by Alexey Tsymlov on 7/9/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - Properties

    @IBOutlet weak var backButton: UIButton!
    
    //MARK: - View life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureBackButton()
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
