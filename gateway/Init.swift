//
//  Init.swift
//  gateway
//
//  Created by ming on 2016. 9. 19..
//  Copyright © 2016년 cccvlm. All rights reserved.
//
import Foundation
import CoreData

class Init{
    init(){
        let mdao = MovieDAO()
        let qdao = QuestionDAO()
        let ldao = LinkDAO()
        
        
        
        let apiURI = URL(string: "http://cccvlm.com/API/gateway/")
        let apidata : Data? = try? Data(contentsOf: apiURI!)
        if apidata != nil{
            mdao.deleteAll()
            qdao.deleteAll()
            ldao.deleteAll()
        do{
            
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata!, options: []) as! NSArray
            
            for tmpMovie in apiDictionary {
                
                let movie = tmpMovie as! [String:Any]
                /*------------Insert Movie VO------------*/
                let mvo = MovieVO()
                mvo.category = Int((movie["category"] as? String)!)
                mvo.index_key = Int((movie["index_key"] as? String)!)
                mvo.title = movie["title"] as? String
                mvo.subtitle = movie["subtitle"] as? String
                mvo.keyword = movie["keyword"] as? String
                mvo.time = movie["time"] as? String
                mvo.description = movie["description"] as? String
                
                /*var tmp = ""
                if let t = movie["question1"] as? NSDictionary{
                    /*let sortedData = sort(dictionary: t)
                    for (k,v) in sortedData{
                        tmp += "\(k). \(v)\n\n"
                    }*/
                    let sortedResponses = t.sorted {
                        switch ($0, $1) {
                        default:
                            let t1 = "\($0.key)"
                            let t2 = "\($1.key)"
                            
                            return Int(t2)! > Int(t1)!
                        }
                    }
                    for (k,v) in sortedResponses{
                        tmp += "\(k). \(v)\n\n"
                    }
                }*/
                
                //mvo.question1 = tmp
                if let t = movie["question1"] as? NSDictionary{
                    mvo.question1 = self.sort(nsdictionary: t)
                }
                //mvo.question1 = sort(nsdictionary: movie["question1"] as! NSDictionary)
                
                /*tmp = ""
                if let t = movie["question2"] as? NSDictionary{
                    //sort 필요
                    /*let sortedData = sort(dictionary: t)
                    for (k,v) in sortedData{
                        tmp += "\(k). \(v)\n\n"                 
                    }*/
                    let sortedResponses = t.sorted {
                        switch ($0, $1) {
                        default:
                            let t1 = "\($0.key)"
                            let t2 = "\($1.key)"
                            
                            return Int(t2)! > Int(t1)!
                        }
                    }
                    for (k,v) in sortedResponses{
                        tmp += "\(k). \(v)\n\n"
                    }
                }*/
                //mvo.question2 = tmp
                if let t = movie["question2"] as? NSDictionary{
                    mvo.question2 = self.sort(nsdictionary: t)
                }
                //mvo.question2 = sort(nsdictionary: movie["question2"] as? NSDictionary)

                mvo.url = movie["url"] as? String
                mvo.lang = movie["lang"] as? String
                
                //mdatabox.save(value: mvo)
                mdao.save(mvo)
                
                var count = 0
                for tmpQuestion in movie["next"] as! NSArray{
                    let question = tmpQuestion as! [String:Any]
                    /*------------Insert Question VO------------*/
                    count += 1
                    let qvo = QuestionVO()
                    qvo.category = mvo.category
                    qvo.index_key = mvo.index_key
                    qvo.question_key = count+1
                    qvo.question = question["question"] as? String
                    
                    for tmpLink in question["link"] as! NSArray{
                        let link = tmpLink as! [String:Any]
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
        }else{
            print("network not connected")
        }
    }
    func sort(nsdictionary dic:NSDictionary)->String{
        var tmp = ""
        //if let t = dic{
        /*let sortedData = sort(dictionary: t)
         for (k,v) in sortedData{
         tmp += "\(k). \(v)\n\n"
         }*/
        let sortedResponses = dic.sorted {
            switch ($0, $1) {
            default:
                let t1 = "\($0.key)"
                let t2 = "\($1.key)"
                
                return Int(t2)! > Int(t1)!
            }
        }
        for (k,v) in sortedResponses{
            tmp += "\(k). \(v)\n\n"
        }
        //}
        
        return tmp
    }
}
