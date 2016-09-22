//
//  MovieDAO.swift
//  gateway
//
//  Created by ming on 2016. 9. 20..
//  Copyright © 2016년 cccvlm. All rights reserved.
//
import UIKit
import CoreData

class MovieDAO{
    
    var managedContext:NSManagedObjectContext
    var entity:NSEntityDescription
    var ent:String?
    init(Entity en:String){
        //print("Movie DAO Connect")
        self.ent = en
        //1
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        
        managedContext = appDelegate.managedObjectContext
        
        entity =  NSEntityDescription.entity(forEntityName: en, in:managedContext)!
        //deleteAll()
    }
    
    func save(_ v:MovieVO){
        let conn = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        conn.setValue(v.category, forKey: "category")
        conn.setValue(v.index_key, forKey: "index_key")
        conn.setValue(v.title, forKey: "title")
        conn.setValue(v.subtitle, forKey: "subtitle")
        conn.setValue(v.keyword, forKey: "keyword")
        conn.setValue(v.time, forKey: "time")
        conn.setValue(v.description, forKey: "descriptions")
        conn.setValue(v.question1, forKey: "question1")
        conn.setValue(v.question2, forKey: "question2")
        conn.setValue(v.url, forKey: "url")
        conn.setValue(v.lang, forKey: "lang")
        do {
            try managedContext.save()            //5
            //people.append(person)
        } catch let error as NSError  {
            print("Movie DAO Could not save \(error), \(error.userInfo)")
        }
    }
    func deleteAll(){
        //let fetchRequest = NSFetchRequest(entityName: self.ent!)
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: self.ent!)
        
        do {
            let results =
                try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if results.count > 0{
                for i in results{
                    //let tmp = i.valueForKey("name") as! String
                    managedContext.delete(i)
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
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: self.ent!)
        
        do {
            let results =
                try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if results.count > 0{
                for i in results{
                    if let tmp = i.value(forKey: k) as? String{
                        print("\(tmp)")
                    }else{
                        let tmp = i.value(forKey: k) as? Int
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
    func getAll(category c:Int)->Array<MovieVO>{
        
        var list = Array<MovieVO>()
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: self.ent!)
        
        do {
            let results =
                try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if results.count > 0{
                for movie in results{
                    let mvo = MovieVO()
                    
                    mvo.category = movie.value(forKey: "category") as? Int
                    if c == mvo.category {
                    
                        mvo.index_key = movie.value(forKey: "index_key") as? Int
                        mvo.title = movie.value(forKey: "title") as? String
                        mvo.subtitle = movie.value(forKey: "subtitle") as? String
                        mvo.keyword = movie.value(forKey: "keyword") as? String
                        mvo.time = movie.value(forKey: "time") as? String
                        mvo.description = movie.value(forKey: "descriptions") as? String
                        mvo.question1 = movie.value(forKey: "question1") as? String
                        mvo.question2 = movie.value(forKey: "question2") as? String
                        mvo.url = movie.value(forKey: "url") as? String
                        mvo.lang = movie.value(forKey: "lang") as? String

                        list.append(mvo)
                    }
                    //print(list)
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
        
        return list
    }
    func getMovie(category c:Int,index_key i:Int)->MovieVO{
        
        var rtn = MovieVO()
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: self.ent!)
        
        do {
            let results =
                try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if results.count > 0{
                for movie in results{
                    let mvo = MovieVO()
                    
                    mvo.category = movie.value(forKey: "category") as? Int
                    if c == mvo.category {
                        mvo.index_key = movie.value(forKey: "index_key") as? Int
                        if i == mvo.index_key {
                            mvo.title = movie.value(forKey: "title") as? String
                            mvo.subtitle = movie.value(forKey: "subtitle") as? String
                            mvo.keyword = movie.value(forKey: "keyword") as? String
                            mvo.time = movie.value(forKey: "time") as? String
                            mvo.description = movie.value(forKey: "descriptions") as? String
                            mvo.question1 = movie.value(forKey: "question1") as? String
                            mvo.question2 = movie.value(forKey: "question2") as? String
                            mvo.url = movie.value(forKey: "url") as? String
                            mvo.lang = movie.value(forKey: "lang") as? String
                            
                            rtn = mvo
                        }
                    }
                }
            }
        }catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return rtn
    }
}
