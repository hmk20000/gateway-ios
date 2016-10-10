//
//  Tab2page1Controller1.swift
//  MissionHub
//
//  Created by ming on 2016. 8. 24..
//  Copyright © 2016년 cccvlm. All rights reserved.
//

import UIKit
import CoreData

class HomeCategory: UITableViewController {
    //var people = [FreshmanVO]()

    var list = Array<String>()
    override func viewDidLoad() {
        list.append("SHORT FILMS")
        list.append("JESUS")
        list.append("MAGDALENA")
        list.append("GOSPEL")
        list.append("HOW TO USE")
          
        self.tableView.rowHeight = 160;
        tableView.separatorStyle = .none
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden =  false
        
        //Status bar style and visibility
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Change status bar color
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = UIColor.darkGray
        }
        self.tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        let tutorialChecker = firstTimeChecker()
        if !tutorialChecker.isFirstTime() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // in half a second..
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TutorialViewController")
                self.modalTransitionStyle = UIModalTransitionStyle.coverVertical
                self.modalPresentationStyle = .currentContext
                self.present(vc!, animated: true, completion: nil)
            }//TutorialViewController
        }
    }
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[(indexPath as NSIndexPath).row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        let bgimage = cell.viewWithTag(101) as? UIImageView
        let label = cell.viewWithTag(102) as? UILabel
        
        bgimage!.image = UIImage(named: "home\((indexPath as NSIndexPath).row+1)btn.png")
        label?.text = row
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let label = cell.viewWithTag(102) as? UILabel
        UIView.animate(withDuration: 0.0, animations: {
            label?.frame.origin.y = (label?.frame.origin.y)! + 30
            label?.alpha = 0.0
        })
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let label = cell.viewWithTag(102) as? UILabel
        UIView.animate(withDuration: 0.5, animations: {
            label?.frame.origin.y = (label?.frame.origin.y)! - 30
            label?.alpha = 1.0
        })
    }
    var paramKey = 0
    var paramtitle = ""
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let nvc = segue.destination as? MovieChoice{
            nvc.paramKey = paramKey
            nvc.paramTitle = paramtitle
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        paramKey = (indexPath as NSIndexPath).row
        paramtitle = self.list[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "segueNext", sender: self)
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
}
class firstTimeChecker{
    var managedContext:NSManagedObjectContext!
    var entity:NSEntityDescription!
    var ent:String!
    init(){
        //print("Movie DAO Connect")
        self.ent = "BasicInfo"
        //1
        managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        entity =  NSEntityDescription.entity(forEntityName: self.ent, in:managedContext)
        
        //deleteAll()
        //saveLoginData(userName: "1")
    }
    
    func save(){
        let conn = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        conn.setValue(true, forKey: "dataload")
        do {
            try managedContext.save()            //5
            //people.append(person)
        } catch let error as NSError  {
            print("Movie DAO Could not save \(error), \(error.userInfo)")
        }
    }
    func isFirstTime()->Bool{
        
        var rtn:Bool! = false
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: self.ent!)
        //fetchRequest.predicate = NSPredicate(format: "category = %@ AND index_key = %@", argumentArray: [c, i])

        do {
            let results =
                try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if results.count > 0{
                rtn = true
            }
        }catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return rtn
    }
}
