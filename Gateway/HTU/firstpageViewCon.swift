//
//  firstpageViewCon.swift
//  4points
//
//  Created by 허재연 on 2016. 8. 9..
//  Copyright © 2016년 C4TK. All rights reserved.
//

import UIKit

class firstpageViewCon: UIViewController{
    
    @IBOutlet var view01: UIView!
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button.frame = view01.frame

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
