//
//  QuestionDAO.swift
//  gateway
//
//  Created by ming on 2016. 9. 20..
//  Copyright © 2016년 cccvlm. All rights reserved.
//
import UIKit
import CoreData

class QuestionDAO{
    var managedContext:NSManagedObjectContext
    var entity:NSEntityDescription
    var ent:String?
    init(Entity en:String){
        //print("Question DAO Connect")
        self.ent = en
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        managedContext = appDelegate.managedObjectContext
        
        entity =  NSEntityDescription.entityForName(en, inManagedObjectContext:managedContext)!
    }
    func save(v:QuestionVO){
        let conn = NSManagedObject(entity: entity,
                                   insertIntoManagedObjectContext: managedContext)
        conn.setValue(v.category, forKey: "category")
        conn.setValue(v.index_key, forKey: "index_key")
        conn.setValue(v.question, forKey: "question")
        conn.setValue(v.question_key, forKey: "question_key")
        
        do {
            try managedContext.save()            //5
            //people.append(person)
        } catch let error as NSError  {
            print("Question DAO Could not save \(error), \(error.userInfo)")
        }
    }
    func deleteAll(){
        let fetchRequest = NSFetchRequest(entityName: self.ent!)
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            if results.count > 0{
                for i in results{
                    //let tmp = i.valueForKey("name") as! String
                    managedContext.deleteObject(i)
                    //print("\(tmp)")
                    do {
                        try managedContext.save()            //5
                        //people.append(person)
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                    
                }
                //print(results)
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    func viewAll(key k:String){
        let fetchRequest = NSFetchRequest(entityName: self.ent!)
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            if results.count > 0{
                for i in results{
                    if let tmp = i.valueForKey(k) as? String{
                        print("\(tmp)")
                    }else{
                        let tmp = i.valueForKey(k) as? Int
                        print("\(tmp)")
                    }
                    //managedContext.deleteObject(i)
                    do {
                        try managedContext.save()            //5
                        //people.append(person)
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                    
                }
                //print(results)
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}