//
//  ViewController.swift
//  Lomotif-IosTask
//
//  Created by Prasanna V on 03/08/15.
//  Copyright (c) 2015 swift. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    
    var collection = Array<PlaylistModel>();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "DataPopulatedNotification:", name:"JsonPopulatesLocalModelAfterANetworkCall", object: nil)

        // Do any additional setup after loading the view, typically from a nib.
        NetworkManager().performNetworkOps();
        print("When are u getting printed");
        println("Finally data");
        println("Data populated");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DataPopulatedNotification(notification: NSNotification){
        //Take Action on Notification
        println("Objetcs count \(SingletonModelDB.sharedInstance.arrayOfPlaylistItems.count)")
    }
    
    deinit
    {
        // Remove from all notifications being observed
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

}

