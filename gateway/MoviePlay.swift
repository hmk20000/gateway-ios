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

extension UITableView {
    func scrollToTop(animated: Bool) {
        setContentOffset(CGPoint.zero, animated: animated)
    }
}
class MoviePlay: UITableViewController {
    var paramVO:MovieVO = MovieVO()
    var category:Int = 0
    var index_key:Int = 0
    var screenHeight:Int = 0
    let fdao = FavoriteDAO()
    let hdao = HistoryDAO()
    
    let serverURL = "http://cccvlm.com/sfproject/movies/"
    var localURL:String!
    var filename:String!
    
    override func viewDidLoad() {
        self.title = paramVO.title
        self.index_key = paramVO.index_key!
        self.category = paramVO.category!
        
        let bounds = UIScreen.main.bounds
        screenHeight = Int(bounds.size.height)
        
        tableView.separatorStyle = .none
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        localURL = dirPaths[0]
        
        filename = "\(paramVO.url!.components(separatedBy: "/")[1])".removingPercentEncoding
        //tableView.layoutMargins = UIEdgeInsets.zero
        //tableView.separatorInset = UIEdgeInsets.zero
        //print("MoviePlaly viewDidLoad() [Local URL] : \(localURL)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //tableView.reloadData()
    }
    func fileCheck(fileName name:String)->String{

        let filemgr = FileManager.default
        let LocalDirectoryFile = "\(localURL as String)/\(name)"
        if filemgr.fileExists(atPath: LocalDirectoryFile) {
            return LocalDirectoryFile
        }else{
            return ""
        }

    }
    func fileFindPlay(){
        var MovieUrl:URL!
        // [1] 파일 존재 여부 확인
        let localUrl = fileCheck(fileName: filename)
        if localUrl != ""{
            print("[1] File exists")
            MovieUrl = URL(fileURLWithPath: localUrl)
        }else{
            download(true as AnyObject)
            MovieUrl = URL(fileURLWithPath: localUrl)
        }
        
        let player = AVPlayer(url: MovieUrl)
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        
        self.present(playerController, animated: true){
            player.play()
        }
        if !hdao.get(MovieVO: paramVO){
            hdao.save(category: paramVO.category!, index_key: paramVO.index_key!)
        }
    }
    
    func OnlinePlay(){
        if let lang = paramVO.lang{
            if let url = paramVO.url{
                var MovieUrl:URL!
                MovieUrl = URL(string: "\(serverURL)/\(lang)/\(url)")!
                
                let player = AVPlayer(url: MovieUrl)
                let playerController = AVPlayerViewController()
                
                playerController.player = player
                
                self.present(playerController, animated: true){
                    player.play()
                }
            }
        }
    }
    
    @IBAction func playMovie(_ sender: AnyObject) {
        /*let alertController = UIAlertController(title: "재생 방법 선택", message:
            "와이파이 환경에서 다운로드 후 재생을 권장합니다.\n 온라인 재생 클릭시 데이터 요금이 발생 할 수 있습니다.", preferredStyle: UIAlertControllerStyle.actionSheet)
        //UIAlertAction(title: "온라인 재생", style: UIAlertActionStyle.default) { (UIAlertAction) in self.fileFindPlay()}
        alertController.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel,handler: nil))
        alertController.addAction(UIAlertAction(title: "온라인 재생", style: UIAlertActionStyle.default) { (UIAlertAction) in self.OnlinePlay()})
        alertController.addAction(UIAlertAction(title: "다운로드 후 재생", style: UIAlertActionStyle.default) { (UIAlertAction) in self.fileFindPlay()})
        self.present(alertController, animated: true, completion: nil)
        */
        
    }
    
    @IBAction func favorite(_ sender: AnyObject) {
        //heart.setBackgroundImage(, for: .normal)
        let heart = sender as! UIButton
        if !fdao.get(MovieVO: paramVO){
            heart.setBackgroundImage(#imageLiteral(resourceName: "heart-click.png"), for: .normal)
            fdao.save(category: paramVO.category!, index_key: paramVO.index_key!)
        }else{
            heart.setBackgroundImage(#imageLiteral(resourceName: "heart.png"), for: .normal)
            fdao.delete(category: paramVO.category!, index_key: paramVO.index_key!)
        }
    }
    
    @IBAction func download(_ sender: AnyObject) {
        if let lang = paramVO.lang{
            if let url = paramVO.url{
                downloadVideoLinkAndCreateAsset("\(serverURL)/\(lang)/\(url)")
            }
        }
        
        print("download")
    }
    
    
    @IBAction func share(_ sender: AnyObject) {
        print("share")
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
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
            let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.light)
            // 2
            let blurView = UIVisualEffectView(effect: darkBlur)
            blurView.frame = (bgimage?.bounds)!
            // 3
            bgimage?.addSubview(blurView)
            /*------*/
            
            let webview = cell.viewWithTag(102) as! UIWebView
            
            webview.alpha = 1
            webview.backgroundColor = UIColor.blue
            //webview.scrollView.isScrollEnabled = false
            //webview.scrollView.bounces = false
            
            webview.allowsInlineMediaPlayback = true
            webview.loadRequest(URLRequest(url:URL(string: "https://www.youtube.com/embed/lI2Ix0N4WUg")!))
            
            /*--------*/

        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell")!
            
            let stackView = cell.viewWithTag(100) as? UIStackView
            let title = cell.viewWithTag(101) as? UILabel
            let subtitle = cell.viewWithTag(102) as? UILabel
            
            if category != 0 {
                stackView?.axis = .vertical
            }
            
            title?.text = paramVO.title
            subtitle?.text = "(\(paramVO.subtitle!))"
            
            title?.sizeToFit()
            
            let heart = cell.viewWithTag(101) as? UIButton
            
            if fdao.get(MovieVO: paramVO){
                heart?.setBackgroundImage(#imageLiteral(resourceName: "heart-click.png"), for: .normal)
            }else{
                heart?.setBackgroundImage(#imageLiteral(resourceName: "heart.png"), for: .normal)
            }
            
            self.tableView.rowHeight = 60;
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell")!
            //screenHeigth - PlayerCell[180] - MoreCell[60] - LinkCell[60] - NavigationBar[40] - title[20] - tabBar[50]
            self.tableView.rowHeight = CGFloat(screenHeight-180-60-60-40-20-50);
            
            let keyword = cell.viewWithTag(103) as? UILabel
            let description = cell.viewWithTag(104) as? UITextView
            
            description?.scrollsToTop = true
            
            description?.isScrollEnabled = true
            
            keyword?.text = paramVO.keyword
            description?.text = paramVO.description
            
           
        case 3:
            if category != 3 {
                self.tableView.rowHeight = 60;
                cell = tableView.dequeueReusableCell(withIdentifier: "LinkCell")!
                let question = cell.viewWithTag(101) as? UIButton
                let next = cell.viewWithTag(102) as? UIButton
                
                question?.layer.cornerRadius = 5
                next?.layer.cornerRadius = 5
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

    func downloadVideoLinkAndCreateAsset(_ videoLink: String) {
        // use guard to make sure you have a valid url
        guard let videoURL = URL(string: videoLink) else { return }
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(documentsDirectoryURL.path)
        // check if the file already exist at the destination folder if you don't want to download it twice
        if !FileManager.default.fileExists(atPath: documentsDirectoryURL.appendingPathComponent(videoURL.lastPathComponent).path) {
            // set up your download task
            
            URLSession.shared.downloadTask(with: videoURL) { (location, response, error) -> Void in
                // use guard to unwrap your optional url
                guard let location = location else { return }
                // create a deatination url with the server response suggested file name
                let destinationURL = documentsDirectoryURL.appendingPathComponent(response?.suggestedFilename ?? videoURL.lastPathComponent)
                
                do {    try FileManager.default.moveItem(at: location, to: destinationURL)
                }  catch let error as NSError { print(error.localizedDescription)}
                print("Video asset created")
                let ddao = DownDAO()
                ddao.save(category: self.paramVO.category!, index_key: self.paramVO.index_key!)
            }.resume()
            
        } else {
            print("file already exists at destination url")
        }
    }
}
