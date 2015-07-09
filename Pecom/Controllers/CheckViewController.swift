//
//  CheckViewController.swift
//  Pecom
//
//  Created by Alexey Tsymlov on 7/9/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit

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
    }
    
    //MARK: - Actions
    
    @IBAction func checkButtonTapped() {
        checkOrder()
    }
    
    private func checkOrder(){
        //TODO:
        performSegueWithIdentifier(toDetailsSegueID, sender: self)
    }

    @IBAction func viewTapped(sender: UITapGestureRecognizer) {
        orderNumberTextField.resignFirstResponder()
    }
    
}

//MARK: - UITextFieldDelegate

extension CheckViewController: UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        orderNumberTextField.resignFirstResponder()
        checkOrder()
        return true
    }
}
