//
//  DetailsViewController.swift
//  Pecom
//
//  Created by Alexey Tsymlov on 7/9/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MASK: - Properties

    @IBOutlet weak var backButton: UIButton!
    
    //MASK: - View life cicle
    
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
    
    //MASK: - Actions
    
    @IBAction func backButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
