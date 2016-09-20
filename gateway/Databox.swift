//
//  databox.swift
//  gateway
//
//  Created by ming on 2016. 9. 19..
//  Copyright © 2016년 cccvlm. All rights reserved.
//
import UIKit
import CoreData

class Databox{
    var managedContext:NSManagedObjectContext
    var entity:NSEntityDescription
    var ent:String?
    init(Entity en:String){
        print("coreData test")
        self.ent = en
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        managedContext = appDelegate.managedObjectContext
        
        entity =  NSEntityDescription.entityForName(en, inManagedObjectContext:managedContext)!
    }
    func connect()->NSManagedObject{
        let connect = NSManagedObject(entity: entity,
                                      insertIntoManagedObjectContext: managedContext)
        return connect
    }
    func save2(){
        do {
            try managedContext.save()            //5
            //people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    func save(value v:MovieVO){
        let person = NSManagedObject(entity: entity,
                                     insertIntoManagedObjectContext: managedContext)
        person.setValue(v.category, forKey: "category")
        person.setValue(v.index_key, forKey: "index_key")
        person.setValue(v.title, forKey: "title")
        person.setValue(v.subtitle, forKey: "subtitle")
        person.setValue(v.keyword, forKey: "keyword")
        person.setValue(v.time, forKey: "time")
        person.setValue(v.description, forKey: "descriptions")
        person.setValue(v.question1, forKey: "question1")
        person.setValue(v.question2, forKey: "question2")
        person.setValue(v.url, forKey: "url")
        person.setValue(v.lang, forKey: "lang")
        do {
            try managedContext.save()            //5
            //people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
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
}