//
//  ViewController.swift
//  superPots
//
//  Created by n.tukmachev on 13.08.2020.
//  Copyright © 2020 tinkoff. All rights reserved.
//
import SnapKit

class ViewController: UIViewController {
    
    lazy var tableView = UITableView()
    lazy var logoView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "jungle.png")
        img.backgroundColor = .red
        
        img.clipsToBounds = true
        return img
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(logoView)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
           make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        logoView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
        
        NetworkLayer.registrClient(name: "wewe", email: "pushwockest.ru", password: "Qwerty", pot: 7, method: "reg")
    }
    
}

