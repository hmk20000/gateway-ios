//
//  InfoViewController.swift
//  Gateway
//
//  Created by ming on 2016. 9. 29..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import UIKit
import MessageUI

class InfoViewController:UIViewController,MFMailComposeViewControllerDelegate{
    override func viewDidLoad() {
        var frame:CGRect = textview.frame;
        frame.size.height = textview.contentSize.height;
        textview.frame = frame;
    }
    
    @IBOutlet var textview: UITextView!
    @IBAction func emailShare(_ sender: AnyObject) {
        //let thirdURL : URL = URL(string: "http://www.google.com")!
        
        let thirdURL : URL = URL(string: "mailto://cccvlm@kccc.org")!
        //전화 - tell://번호
        //문자 - sms://번호
        //메일 - mailto://메일주소
        UIApplication.shared.open(thirdURL, options: [:], completionHandler: nil)
        //UIApplication.shared.openURL(thirdURL)
    }
    @IBAction func fbShare(_ sender: AnyObject) {
        self.msg(message: "준비 중인 기능입니다.")
    }
    @IBAction func kakaoShare(_ sender: AnyObject) {
        self.msg(message: "준비 중인 기능입니다.")
    }
    func msg(message msg:String){
        let alertController = UIAlertController(title: msg, message:
            "", preferredStyle: UIAlertControllerStyle.alert)
        //UIAlertAction(title: "온라인 재생", style: UIAlertActionStyle.default) { (UIAlertAction) in self.fileFindPlay()}
        //alertController.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel,handler: nil))
        alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default))
        //alertController.addAction(UIAlertAction(title: "다운로드 후 재생", style: UIAlertActionStyle.default))
        self.present(alertController, animated: true, completion: nil)
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
}
