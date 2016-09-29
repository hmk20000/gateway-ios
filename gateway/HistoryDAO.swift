//
//  HistoryDAO.swift
//  Gateway
//
//  Created by ming on 2016. 9. 28..
//  Copyright © 2016년 cccvlm. All rights reserved.
//


import UIKit
import CoreData

class HistoryDAO{
    
    var managedContext:NSManagedObjectContext!
    var entity:NSEntityDescription!
    var ent:String!
    
    init(){
        self.ent = "History"
        managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        entity =  NSEntityDescription.entity(forEntityName: self.ent, in:managedContext)
    }
    func save(category c:Int,index_key i:Int){
        let conn = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        conn.setValue(c, forKey: "category")
        conn.setValue(i, forKey: "index_key")
        do {
            try managedContext.save()            //5
            //people.append(person)
        } catch let error as NSError  {
            print("Favorite DAO Could not save \(error), \(error.userInfo)")
        }
    }
    func deleteAll(){
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: self.ent!)
        
        do {
            let results =
                try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if results.count > 0{
                for i in results{
                    managedContext.delete(i)
                    do {
                        try managedContext.save()            //5
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                }
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    func delete(category c:Int,index_key i:Int){
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: self.ent!)
        fetchRequest.predicate = NSPredicate(format: "category = %@ AND index_key = %@", argumentArray: [c, i])
        
        do {
            let results =
                try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if results.count > 0{
                managedContext.delete(results[0])
                do {
                    try managedContext.save()            //5
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    func delete(HistoryVO vo:HistoryVO){
        delete(category: vo.category!, index_key: vo.index_key!)
    }
    
    func get(category c:Int,index_key i:Int)->Bool{
        
        var rtn = false
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: self.ent!)
        fetchRequest.predicate = NSPredicate(format: "category = %@ AND index_key = %@", argumentArray: [c, i])
        
        do {
            let results =
                try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if results.count > 0{
                rtn = true
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return rtn
    }
    func get(MovieVO vo:MovieVO)->Bool{
        return get(category: vo.category!, index_key: vo.index_key!)
    }
    func getAll()->Array<HistoryVO>{
        
        var list = Array<HistoryVO>()
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: self.ent!)
        
        do {
            let results =
                try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if results.count > 0{
                for movie in results{
                    let vo = HistoryVO()
                    
                    vo.category = movie.value(forKey: "category") as? Int
                    vo.index_key = movie.value(forKey: "index_key") as? Int
                    
                    list.append(vo)
                }
                do {
                    try managedContext.save()            //5
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return list.reversed()
    }
}
