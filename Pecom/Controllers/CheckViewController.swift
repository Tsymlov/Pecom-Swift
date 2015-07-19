//
//  CheckViewController.swift
//  Pecom
//
//  Created by Alexey Tsymlov on 7/9/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit
import Alamofire

class CheckViewController: UIViewController{
    
    //MARK: - Properties
    
    @IBOutlet weak var orderNumberTextField: UITextField!
    private let toDetailsSegueID = "FromCheckToDetails"
    
    //MARK: - View life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        clearOrderNumberTextField()
    }
    
    private func clearOrderNumberTextField(){
        orderNumberTextField.text = ""
    }
    
    //MARK: - Actions
    
    @IBAction func checkButtonTapped() {
        performSegueWithIdentifier(toDetailsSegueID, sender: nil)
    }

    @IBAction func viewTapped(sender: UITapGestureRecognizer) {
        orderNumberTextField.resignFirstResponder()
    }
    
    //MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let details = segue.destinationViewController as! DetailsViewController
        details.orderNumber = orderNumberTextField.text
    }
}

//MARK: - UITextFieldDelegate

extension CheckViewController: UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        orderNumberTextField.resignFirstResponder()
        performSegueWithIdentifier(toDetailsSegueID, sender: nil)
        return true
    }
}