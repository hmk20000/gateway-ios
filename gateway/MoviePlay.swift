//
//  MoviePlay.swift
//  gateway
//
//  Created by ming on 2016. 9. 20..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MoviePlay: UITableViewController {
    var paramVO:MovieVO = MovieVO()
    var category:Int = 0
    var index_key:Int = 0
    override func viewDidLoad() {
        self.title = paramVO.title
        self.index_key = paramVO.index_key!
        self.category = paramVO.category!
        
        tableView.separatorStyle = .None
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
    @IBAction func favorite(sender: AnyObject) {
        print("favorite")
    }
    @IBAction func download(sender: AnyObject) {
        print("download")
    }
    @IBAction func share(sender: AnyObject) {
        print("share")
    }
    
    override func tableView(tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        //return self.list.count
        return 4
    }
    
    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell")!
            
            self.tableView.rowHeight = 180;
            let bgimage = cell.viewWithTag(101) as? UIImageView
            
            var imageName:String?

            switch category {
            case 1:
                imageName = "SF\(self.index_key)btn.png"
            default:
                imageName = "SF\(self.index_key)btn.png"
            }
            
            bgimage!.image = UIImage(named: imageName!)
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("MoreCell")!
            
            self.tableView.rowHeight = 40;
            /*let title = cell.viewWithTag(101) as? UILabel
            let keyword = cell.viewWithTag(102) as? UILabel
            let description = cell.viewWithTag(103) as? UILabel
            
            title?.text = "1"
            keyword?.text = "3333"
            description?.text = "asdfasdf"*/
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("InfoCell")!
            
            self.tableView.rowHeight = 180;
            let title = cell.viewWithTag(101) as? UILabel
            let keyword = cell.viewWithTag(102) as? UILabel
            let description = cell.viewWithTag(103) as? UILabel
            
            title?.text = paramVO.title
            keyword?.text = paramVO.keyword
            description?.text = paramVO.description
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("LinkCell")!
            
            /*self.tableView.rowHeight = 180;
            let title = cell.viewWithTag(101) as? UILabel
            let keyword = cell.viewWithTag(102) as? UILabel
            let description = cell.viewWithTag(103) as? UILabel
            
            title?.text = "1"
            keyword?.text = "3333"
            description?.text = "asdfasdf"*/
        default: break

        }
        //let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell")!
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.blackColor()
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    /*var MovieKey=0
    var paramVO = MovieVO()
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nvc = segue.destinationViewController as? ShortFilmPlay{
            nvc.paramKey = MovieKey
            nvc.paramVO = paramVO
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MovieKey = self.list[indexPath.row].index_key!
        paramVO = self.list[indexPath.row]
        self.performSegueWithIdentifier("seguePlay", sender: self)
    }*/
}