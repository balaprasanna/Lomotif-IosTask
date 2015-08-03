//
//  NetworkManager.swift
//  Lomotif-IosTask
//
//  Created by Prasanna V on 03/08/15.
//  Copyright (c) 2015 swift. All rights reserved.
//

import Foundation

class NetworkManager {
    
    func performNetworkOps(){
        var baseUrl:String = "https://itunes.apple.com/sg/rss/topsongs/limit=50/explicit=true/json";
        let urlPath = baseUrl
        let url: NSURL = NSURL(string: urlPath)!
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            
            if error != nil {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as! NSDictionary
            if err != nil {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            
            let json = JSON(jsonResult)
            //println("found \(json) challenges")
           
            //PlaylistModel
            self.PopulateModel(json);
            
        })
        task.resume()
    }
    
    func PopulateModel(json:JSON){
        let count: Int? = json["feed"]["entry"].array?.count
        if let ct = count {
            for index in 0...ct-1 {
                if let name = json["feed"]["entry"][index]["im:name"]["label"].string {
                    println(name)
                }
                if let name = json["feed"]["entry"][index]["im:name"]["label"].string {
                    println(name)
                }
                if let name = json["feed"]["entry"][index]["im:name"]["label"].string {
                    println(name)
                }
                if let name = json["feed"]["entry"][index]["im:name"]["label"].string {
                    println(name)
                }
            }
        }
    }
}