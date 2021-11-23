//
//  ViewController.swift
//  GoShop
//
//  Created by Hong Cheng Yen on 2021/10/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIStepper.appearance().layer.cornerRadius = 10
    }


    @IBAction func testbutton(_ sender: Any) {
        print("hi")
    }
}

