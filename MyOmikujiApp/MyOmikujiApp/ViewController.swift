//
//  ViewController.swift
//  MyOmikujiApp
//
//  Created by kosuke.arase on 2019/05/02.
//  Copyright © 2019 kosuke.arase. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBAction func getOmikuji(_ sender: Any) {
        let results = ["大吉", "吉", "中吉", "凶", "大凶"]
        let random = arc4random_uniform(UInt32(results.count))
        self.myLabel.text = String(results[Int(random)])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        myLabel.layer.borderColor = UIColor.orange.cgColor
//        myLabel.layer.borderWidth = 5
        myLabel.layer.cornerRadius = myLabel.bounds.width / 2
        myLabel.layer.masksToBounds = true
    }


}

