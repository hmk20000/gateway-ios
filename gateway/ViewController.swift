//
//  ViewController.swift
//  gateway
//
//  Created by ming on 2016. 9. 19..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        imageView.image = UIImage(named: "LaunchScreen.png")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

