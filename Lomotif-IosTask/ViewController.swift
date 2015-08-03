//
//  ViewController.swift
//  Lomotif-IosTask
//
//  Created by Prasanna V on 03/08/15.
//  Copyright (c) 2015 swift. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var timer = NSTimer()
    var collection = Array<PlaylistModel>();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "DataPopulatedNotification:", name:"JsonPopulatesLocalModelAfterANetworkCall", object: nil)
        
        tableView.delegate = self;
        tableView.dataSource = self;

        NetworkManager().performNetworkOps();
        //NSTimer.scheduledTimerWithTimeInterval(0.1, target: self.tableView, selector: Selector("reloadData"), userInfo: nil, repeats: true)
        //potentially dangerous...but let it be for a while
        
    }
    
    func DataPopulatedNotification(notification: NSNotification){
        //Take Action on Notification
        println("Objetcs count \(SingletonModelDB.sharedInstance.arrayOfPlaylistItems.count)")
        self.tableView.reloadData();
    }
    
    deinit
    {
        // Remove from all notifications being observed
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SingletonModelDB.sharedInstance.arrayOfPlaylistItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as! CustomCell
        
        cell.title.text = SingletonModelDB.sharedInstance.arrayOfPlaylistItems[indexPath.row].title;
        //cell.imageview.image = UIImage(named: ""));
            //SingletonModelDB.sharedInstance.arrayOfPlaylistItems[0].title;
        cell.name.text = SingletonModelDB.sharedInstance.arrayOfPlaylistItems[indexPath.row].name;
        return cell
    }
    
 
}

