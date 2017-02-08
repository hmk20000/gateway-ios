//
//  TabBarController.swift
//  Gateway
//
//  Created by ming on 2016. 10. 5..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import UIKit

class TabBarController:UITabBarController{
    /*-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if(item.tag == 1) {
    //your code for tab item 1
    }
    else if(item.tag == 2) {
    //your code for tab item 2
    }
    }*/
    var count:Int?
    override func viewDidLoad() {
        count = 0
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "INFORMATION"{
            count = count! + 1
            if count == 10{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // in half a second..
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "EsterEgg") as? EsterEgg
                    self.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                    self.modalPresentationStyle = .currentContext
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }else{
            count = 0
        }
        
    }
}
