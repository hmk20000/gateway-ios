//
//  page2ViewController.swift
//  4points
//
//  Created by ming on 2016. 8. 10..
//  Copyright © 2016년 C4TK. All rights reserved.
//

import UIKit

class Page2ViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func startApp(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
