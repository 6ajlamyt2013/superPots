//
//  ViewController.swift
//  superPots
//
//  Created by n.tukmachev on 13.08.2020.
//  Copyright © 2020 tinkoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkLayer.registrClient(name: "wewe", email: "pushwockest.ru", password: "Qwerty", pot: 7, method: "reg")
    }
}

