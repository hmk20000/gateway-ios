//
//  Init.swift
//  gateway
//
//  Created by ming on 2016. 9. 19..
//  Copyright © 2016년 cccvlm. All rights reserved.
//
import UIKit
import CoreData

class Init{
    init(){
        let mdao = MovieDAO(Entity: "Movie")
        let qdao = QuestionDAO(Entity: "Question")
        let ldao = LinkDAO(Entity: "Link")
        
        mdao.deleteAll()
        qdao.deleteAll()
        ldao.deleteAll()
        
        let apiURI = NSURL(string: "http://cccvlm.com/API/gateway/")
        let apidata : NSData? = NSData(contentsOfURL: apiURI!)
        
        do{
            let apiDictionary = try NSJSONSerialization.JSONObjectWithData(apidata!, options: []) as! NSArray
            for movie in apiDictionary {
                
                /*------------Insert Movie VO------------*/
                let mvo = MovieVO()
                mvo.category = Int((movie["category"] as? String)!)
                mvo.index_key = Int((movie["index_key"] as? String)!)
                mvo.title = movie["title"] as? String
                mvo.subtitle = movie["subtitle"] as? String
                mvo.keyword = movie["keyword"] as? String
                mvo.time = movie["time"] as? String
                mvo.description = movie["description"] as? String
                
                var tmp = ""
                if let t = movie["question1"] as? NSDictionary{
                    //sort 필요
                    for (k,v) in t{
                        tmp += "\(k). \(v)\n\n"
                    }
                }
                
                mvo.question1 = tmp
                
                tmp = ""
                if let t = movie["question2"] as? NSDictionary{
                    //sort 필요
                    for (k,v) in t{
                        tmp += "\(k). \(v)\n\n"                 
                    }
                }
                mvo.question2 = tmp

                mvo.url = movie["url"] as? String
                mvo.lang = movie["lang"] as? String
                
                //mdatabox.save(value: mvo)
                mdao.save(mvo)
                
                var count = 0
                for question in movie["next"] as! NSArray{
                    
                    /*------------Insert Question VO------------*/
                    count += 1
                    let qvo = QuestionVO()
                    qvo.category = mvo.category
                    qvo.index_key = mvo.index_key
                    qvo.question_key = count+1
                    qvo.question = question["question"] as? String
                    
                    for link in question["link"] as! NSArray{
                        
                        /*------------Insert Link VO------------*/
                        let lvo = LinkVO()
                        lvo.category = qvo.category
                        lvo.index_key = qvo.index_key
                        lvo.question_key = qvo.question_key
                        lvo.next_category = Int((link["category"] as? String)!)
                        lvo.next_index_key = Int((link["index_key"] as? String)!)
                        
                        ldao.save(lvo)
                    }
                    
                    qdao.save(qvo)
                    //print(qvo.question)
                }
                //qdao.viewAll(key: "question")
            }
        }catch{
            
        }
        //mdao.viewAll(key: "descriptions")

    }
}