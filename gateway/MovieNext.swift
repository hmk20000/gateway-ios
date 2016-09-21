//
//  MovieNext.swift
//  gateway
//
//  Created by ming on 2016. 9. 21..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import UIKit

class MovieNext:UIViewController{
    var paramVO = MovieVO()
    
    override func viewDidLoad() {
        self.title = "Next"
    }
    @IBAction func test(sender: AnyObject) {
        performSegueWithIdentifier("segueLink", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nvc = segue.destinationViewController as? MoviePlay{
            nvc.paramVO = self.paramVO
        }
    }

}
