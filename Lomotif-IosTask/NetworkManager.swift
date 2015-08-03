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
                println("JSON Error \(err!.localizedDescription)")
            }
            
            let json = JSON(jsonResult)
            println("found \(json) challenges")
           
            //PlaylistModel
            

            self.PopulateModel(json);
            
        })
        task.resume()
    }
    
    func PopulateModel(json:JSON){
        let count: Int? = json["feed"]["entry"].array?.count

        if let ct = count {
            
            for index in 0...ct-1 {
                var model = PlaylistModel()
                
                if let title = json["feed"]["entry"][index]["im:name"]["label"].string {
                    model.title = title;
                    println(title)
                }
                if let imageurl = json["feed"]["entry"][index]["im:image"][2]["label"].string {
                    model.imageUrl = imageurl
                    println(imageurl)
                }
                if let name = json["feed"]["entry"][index]["im:artist"]["label"].string {
                    model.name = name;
                    println(name)
                }
                
                SingletonModelDB.sharedInstance.arrayOfPlaylistItems.append(model)
            }
        }
        // Send Notification about model change to controller
        NSNotificationCenter.defaultCenter().postNotificationName("JsonPopulatesLocalModelAfterANetworkCall", object: nil)

    }
}