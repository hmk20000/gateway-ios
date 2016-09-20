//
//  ShortFilmsPlay.swift
//  gateway
//
//  Created by ming on 2016. 9. 20..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ShortFilmPlay:UIViewController{
    var paramKey:Int = 0
    var paramVO:MovieVO = MovieVO()
    
    @IBOutlet var playBtn: UIButton!
    @IBOutlet var UiTitle: UILabel!
    @IBOutlet var UiKeyword: UILabel!
    @IBOutlet var UiDescription: UILabel!
    @IBOutlet var thumbnail: UIImageView!
    
    
    override func viewDidLoad() {
        self.title = paramVO.title
        var imageName:String?
        switch paramKey {
        case 0:
            imageName = "SF\(paramKey)btn.png"
        default:
            imageName = "SF\(paramKey)btn.png"
        }
        thumbnail.image = UIImage(named: imageName!)
        //playBtn.setBackgroundImage( UIImage(named: imageName!), forState: UIControlState.Focused)
        //playBtn.frame.size.height = 1
        //descriptions.text = paramVO.question1
        
        UiTitle.text = paramVO.title
        UiKeyword.text = paramVO.keyword
        UiDescription.text = paramVO.description
    }
    
    @IBAction func playMovie(sender: AnyObject) {
        
        if let lang = paramVO.lang{
            if let url = paramVO.url{
                let MovieUrl = NSURL(string: "http://cccvlm.com/sfproject/movies/\(lang)/\(url)")!
                let player = AVPlayer(URL: MovieUrl)
                let playerController = AVPlayerViewController()
                
                playerController.player = player
                
                self.presentViewController(playerController, animated: true){
                    player.play()
                }
            }
        }
    }
}
