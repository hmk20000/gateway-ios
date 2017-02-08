//
//  HistoryViewController.swift
//  Gateway
//
//  Created by ming on 2016. 9. 28..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import  UIKit

class HistoryViewController:UITableViewController{
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let hdao = HistoryDAO()
    
    var paramKey:Int = 0
    var paramTitle:String = ""
    var list = Array<HistoryVO>()
    override func viewDidLoad() {
        
        self.title = paramTitle
        
        self.tableView.rowHeight = 160;
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        list = hdao.getAll()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        let tmp = self.list[(indexPath as NSIndexPath).row]
        let mdao = MovieDAO()
        let row = mdao.getMovie(category: tmp.category!, index_key: tmp.index_key!)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        let bgimage = cell.viewWithTag(101) as? UIImageView
        let title = cell.viewWithTag(102) as? UILabel
        let subtitle = cell.viewWithTag(103) as? UILabel
        
        var imageName:String?
        
        let index_key = tmp.index_key!
        switch tmp.category! {
        case 0:
            imageName = "SF\(index_key)btn.png"
        case 1:
            imageName = "JF\(index_key)btn.png"
        case 2:
            imageName = "MD\(index_key)btn.png"
        case 3:
            imageName = "GS\(index_key)btn.png"
        case 4:
            imageName = "HU\(index_key)btn.png"
        default:
            imageName = ""
        }
        
        bgimage!.image = UIImage(named: imageName!)
        title?.text = row.title
        subtitle?.text = row.subtitle
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    var paramVO = MovieVO()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nvc = segue.destination as? MoviePlay{
            nvc.paramVO = paramVO
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tmp = self.list[(indexPath as NSIndexPath).row]
        let mdao = MovieDAO()
        
        paramVO = mdao.getMovie(category: tmp.category!, index_key: tmp.index_key!)
        self.performSegue(withIdentifier: "HistoryPlaySegue", sender: self)
        
        let hdao = HistoryDAO()
        if hdao.get(MovieVO: paramVO){
            hdao.delete(category: paramVO.category!, index_key: paramVO.index_key!)
        }
        hdao.save(category: paramVO.category!, index_key: paramVO.index_key!)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let tmp = self.list[(indexPath as NSIndexPath).row]
            hdao.delete(category: tmp.category!, index_key: tmp.index_key!)
            
            list.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let title = cell.viewWithTag(102) as? UILabel
        let subtitle = cell.viewWithTag(103) as? UILabel
        UIView.animate(withDuration: 0.0, animations: {
            title?.frame.origin.y = (title?.frame.origin.y)! + 30
            subtitle?.frame.origin.y = (subtitle?.frame.origin.y)! + 30
            title?.alpha = 0.0
            subtitle?.alpha = 0.0
        })
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let title = cell.viewWithTag(102) as? UILabel
        let subtitle = cell.viewWithTag(103) as? UILabel
        UIView.animate(withDuration: 0.5, animations: {
            title?.frame.origin.y = (title?.frame.origin.y)! - 30
            subtitle?.frame.origin.y = (subtitle?.frame.origin.y)! - 30
            title?.alpha = 1
            subtitle?.alpha = 1
        })
    }
}
