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
    var entity:NSEntityDescription!
    var ent:String!
    init(){
        //print("Question DAO Connect")
        self.ent = "Question"
        //1
        managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        entity =  NSEntityDescription.entity(forEntityName: self.ent, in:managedContext)
    }
    func save(_ v:QuestionVO){
        let conn = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
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
    func getAll(category c:Int,index_key i:Int)->Array<QuestionVO>{
        var list = Array<QuestionVO>()
        
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: self.ent!)
        
        do {
            let results =
                try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if results.count > 0{
                for question in results{
                    let qvo = QuestionVO()
                    
                    qvo.category = question.value(forKey: "category") as? Int
                    if c == qvo.category {
                        qvo.index_key = question.value(forKey: "index_key") as? Int
                        if i == qvo.index_key {
                            qvo.question = question.value(forKey: "question") as? String
                            qvo.question_key = question.value(forKey: "question_key") as? Int
                            
                            list.append(qvo)
                        }
                    }
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

}
