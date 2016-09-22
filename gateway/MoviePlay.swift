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
    var screenHeight:Int = 0
    
    override func viewDidLoad() {
        self.title = paramVO.title
        self.index_key = paramVO.index_key!
        self.category = paramVO.category!
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        screenHeight = Int(height)-240-160
        
        //print(paramVO.description)
        tableView.separatorStyle = .none
    }
    
    @IBAction func playMovie(_ sender: AnyObject) {
        if let lang = paramVO.lang{
            if let url = paramVO.url{
                let MovieUrl = URL(string: "http://cccvlm.com/sfproject/movies/\(lang)/\(url)")!
                let player = AVPlayer(url: MovieUrl)
                let playerController = AVPlayerViewController()
                
                playerController.player = player
                
                self.present(playerController, animated: true){
                    player.play()
                }
            }
        }
    }
    @IBAction func favorite(_ sender: AnyObject) {
        print("favorite")
    }
    @IBAction func download(_ sender: AnyObject) {
        print("download")
    }
    @IBAction func share(_ sender: AnyObject) {
        print("share")
    }
    
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        //return self.list.count
        return 4
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch (indexPath as NSIndexPath).row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell")!
            
            self.tableView.rowHeight = 180;
            let bgimage = cell.viewWithTag(101) as? UIImageView
            
            var imageName:String?

            switch category {
            case 0:
                imageName = "SF\(self.index_key)btn.png"
            case 1:
                imageName = "JF\(self.index_key)btn.png"
            case 2:
                imageName = "MD\(self.index_key)btn.png"
            case 3:
                imageName = "GS\(self.index_key)btn.png"
            default:
                imageName = ""
            }
            bgimage!.image = UIImage(named: imageName!)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell")!
            
            self.tableView.rowHeight = 40;
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell")!
            
            self.tableView.rowHeight = CGFloat(screenHeight);
            let stackView = cell.viewWithTag(100) as? UIStackView
            let title = cell.viewWithTag(101) as? UILabel
            let subtitle = cell.viewWithTag(102) as? UILabel
            let keyword = cell.viewWithTag(103) as? UILabel
            let description = cell.viewWithTag(104) as? UILabel

            if category != 0 {
                stackView?.axis = .vertical
            }
            
            title?.text = paramVO.title
            subtitle?.text = "(\(paramVO.subtitle!))"
            keyword?.text = paramVO.keyword
            description?.text = paramVO.description
            
            title?.sizeToFit()
        case 3:
            if category != 3 {
                self.tableView.rowHeight = 60;
                cell = tableView.dequeueReusableCell(withIdentifier: "LinkCell")!
            }else{
                self.tableView.rowHeight = 60;
                cell = tableView.dequeueReusableCell(withIdentifier: "BlackCell")!
            }
        default: break

        }
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    @IBAction func question(_ sender: AnyObject) {
        performSegue(withIdentifier: "segueQuestion", sender: self)
    }
    @IBAction func next(_ sender: AnyObject) {
        performSegue(withIdentifier: "segueNext", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nvc = segue.destination as? MovieQuestion{
            nvc.paramVO = self.paramVO
        }
        else if let nvc = segue.destination as? MovieNext{
            nvc.paramVO = self.paramVO
        }
        
    }
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MovieKey = self.list[indexPath.row].index_key!
        paramVO = self.list[indexPath.row]
        self.performSegueWithIdentifier("seguePlay", sender: self)
    }*/
}
