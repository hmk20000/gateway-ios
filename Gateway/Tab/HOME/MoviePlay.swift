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
    var screenHeight:CGFloat = 0
    var screenWidth:CGFloat = 0
    let fdao = FavoriteDAO()
    let hdao = HistoryDAO()
    
    let serverURL = "http://cccvlm.com/sfproject/movies/"
    var localURL:String!
    var filename:String!
    var isVertical:Bool! = true
    
    override func viewDidLoad() {
        self.title = paramVO.title
        self.index_key = paramVO.index_key!
        self.category = paramVO.category!
        
        tableView.separatorStyle = .none
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        localURL = dirPaths[0]
        if (paramVO.url != nil){
            filename = "\(paramVO.url!.components(separatedBy: "/")[1])".removingPercentEncoding
        }else{
            let alertController = UIAlertController(title: "준비중", message:
                "준비중인 영상 입니다.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default) { (UIAlertAction) in self.navigationBack()})
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        let bounds = UIScreen.main.bounds
        if UIDevice.current.orientation.isLandscape {
            screenHeight = bounds.size.width
            screenWidth = bounds.size.height
            //print("Landscape")
            isVertical = false
        } else {
            screenHeight = bounds.size.height
            screenWidth = bounds.size.width
            //print("Vertical")
            isVertical = true
        }
        //print("MoviePlaly viewDidLoad() [Local URL] : \(localURL)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //tableView.reloadData()
    }
    func navigationBack(){
        //navigationController?.popViewController(animated: true)
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
            //print("Already File exists")
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
        if !hdao.get(MovieVO: paramVO){
            hdao.save(category: paramVO.category!, index_key: paramVO.index_key!)
        }
    }
    
    @IBAction func playMovie(_ sender: AnyObject) {
        /*let alertController = UIAlertController(title: "재생 방법 선택", message:
            "와이파이 환경에서 다운로드 후 재생을 권장합니다.\n 온라인 재생 클릭시 데이터 요금이 발생 할 수 있습니다.", preferredStyle: UIAlertControllerStyle.alert)
        //UIAlertAction(title: "온라인 재생", style: UIAlertActionStyle.default) { (UIAlertAction) in self.fileFindPlay()}
        alertController.addAction(UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel,handler: nil))
        alertController.addAction(UIAlertAction(title: "온라인 재생", style: UIAlertActionStyle.default) { (UIAlertAction) in self.OnlinePlay()})
        alertController.addAction(UIAlertAction(title: "다운로드 재생", style: UIAlertActionStyle.default) { (UIAlertAction) in self.fileFindPlay()})
        self.present(alertController, animated: true, completion: nil)
        */
        var MovieUrl:URL!
        // [1] 파일 존재 여부 확인
        let localUrl = fileCheck(fileName: filename)
        if localUrl != ""{
            //print("Already File exists")
            MovieUrl = URL(fileURLWithPath: localUrl)
        }else{
            if let lang = paramVO.lang{
                if let url = paramVO.url{
                    MovieUrl = URL(string: "\(serverURL)/\(lang)/\(url)")!
                }
            }
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
    
    @IBAction func favorite(_ sender: AnyObject) {
        //heart.setBackgroundImage(, for: .normal)
        let heart = sender as! UIButton
        favorite_click(UIButton: heart)
    }
    func favorite_click(UIButton btn:UIButton){
        if !fdao.get(MovieVO: paramVO){
            btn.setBackgroundImage(#imageLiteral(resourceName: "heart-click.png"), for: .normal)
            fdao.save(category: paramVO.category!, index_key: paramVO.index_key!)
        }else{
            btn.setBackgroundImage(#imageLiteral(resourceName: "heart.png"), for: .normal)
            fdao.delete(category: paramVO.category!, index_key: paramVO.index_key!)
        }
    }
    @IBAction func download(_ sender: AnyObject) {
        if (paramVO.index_key == 11) ||  (paramVO.index_key == 12){
            let alertController = UIAlertController(title: "다운로드 실패", message:
                "저작권 문제로 다운로드 할 수 없습니다.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default))
            self.present(alertController, animated: true, completion: nil)
        }else{
        if let lang = paramVO.lang{
            if let url = paramVO.url{
                // [1] 파일 존재 여부 확인
                let localUrl = fileCheck(fileName: filename)
                if localUrl == ""{
                    downloadVideoLinkAndCreateAsset("\(serverURL)/\(lang)/\(url)")
                    let alertController = UIAlertController(title: "다운로드 시작", message:
                        "[\(paramVO.title!)] 다운로드 합니다. 다운로드 완료시 [MY VIDEOS] -> [다운로드] 에서 확인 가능합니다.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default))
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: "다운완료", message:
                        "이미 다운로드 받으셨습니다.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default))
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
        }
        //print("download")
    }
    
    
    @IBAction func share(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "준비중", message:
            "공유 기능은 준비중 입니다.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default))
        self.present(alertController, animated: true, completion: nil)
        //print("share")
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
            case 4:
                imageName = "HU\(self.index_key)btn.png"
            default:
                imageName = ""
            }
            bgimage!.image = UIImage(named: imageName!)
            let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.light)
            // 2
            let blurView = UIVisualEffectView(effect: darkBlur)
            //blurView.frame = (bgimage?.bounds)!
            blurView.frame = cell.frame
            if isVertical == true{
                blurView.frame.size.width = screenWidth
            }else{
                blurView.frame.size.width = CGFloat(screenHeight)
            }
            
            
            // 3
            bgimage?.addSubview(blurView)
            /*---유투브 플레이---*/
            if (paramVO.index_key == 11) ||  (paramVO.index_key == 12){
                let webview = cell.viewWithTag(102) as! UIWebView
                
                webview.alpha = 1
                webview.backgroundColor = UIColor.black
                webview.scrollView.isScrollEnabled = false
                webview.scrollView.bounces = false
                
                webview.allowsInlineMediaPlayback = true
                if paramVO.index_key == 11{
                    webview.loadRequest(URLRequest(url:URL(string: "https://www.youtube.com/embed/P5_Msrdg3Hk")!))
                }
                if paramVO.index_key == 12{
                    webview.loadRequest(URLRequest(url:URL(string: "https://www.youtube.com/embed/3ocrRLz8pH8")!))
                }
            }
            

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
            
            let heart = cell.viewWithTag(103) as! UIButton
            
            if fdao.get(MovieVO: paramVO){
                heart.setBackgroundImage(#imageLiteral(resourceName: "heart-click.png"), for: .normal)
            }else{
                heart.setBackgroundImage(#imageLiteral(resourceName: "heart.png"), for: .normal)
            }
            
            self.tableView.rowHeight = 60;
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell")!
            //screenHeigth - PlayerCell[180] - MoreCell[60] - LinkCell[60] - NavigationBar[40] - title[20] - tabBar[50]
            let InfoCellHeight:CGFloat = 180+60+60+40+20+50
            if isVertical == true{
                self.tableView.rowHeight = screenHeight-InfoCellHeight
            }else{
                self.tableView.rowHeight = screenWidth-InfoCellHeight
            }
            
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            //print("Landscape")
            isVertical = false
        } else {
            //print("Vertical")
            isVertical = true
        }
        self.tableView.reloadData()
    }
    func downloadVideoLinkAndCreateAsset(_ videoLink: String) {
        // use guard to make sure you have a valid url
        guard let videoURL = URL(string: videoLink) else { return }
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        //print(documentsDirectoryURL.path)
        // check if the file already exist at the destination folder if you don't want to download it twice
        if !FileManager.default.fileExists(atPath: documentsDirectoryURL.appendingPathComponent(videoURL.lastPathComponent).path) {
            // set up your download task
            
            URLSession.shared.downloadTask(with: videoURL) { (location, response, error) -> Void in
                // use guard to unwrap your optional url
                guard let location = location else { return }
                // create a deatination url with the server response suggested file name
                let destinationURL = documentsDirectoryURL.appendingPathComponent(response?.suggestedFilename ?? videoURL.lastPathComponent)
                var noError:Bool = true
                do {    try FileManager.default.moveItem(at: location, to: destinationURL)
                }  catch let error as NSError { print(error.localizedDescription)
                    noError = false
                }
                print("Video asset created")
                let ddao = DownDAO()
                if noError{
                    ddao.save(category: self.paramVO.category!, index_key: self.paramVO.index_key!)
                }
            }.resume()
            
        } else {
            print("file already exists at destination url")
        }
    }
}
