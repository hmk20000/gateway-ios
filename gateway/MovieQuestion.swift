//
//  MovieQuestion.swift
//  gateway
//
//  Created by ming on 2016. 9. 21..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import UIKit

class MovieQuestion:UIViewController{
    
    var paramVO = MovieVO()
    
    @IBOutlet var q1: UITextView!
    @IBOutlet var q2: UITextView!
    
    override func viewDidLoad() {
        self.title = "Question"
        
        q1.text = paramVO.question1
        q2.text = paramVO.question2
    }
}
