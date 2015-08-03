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
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self.tableView, selector: Selector("reloadData"), userInfo: nil, repeats: true)
        //potentially dangerous theoritically.....but let it be for a while to have a nice non blocking UI.
        
    }
    
    func DataPopulatedNotification(notification: NSNotification){
        //Take Action on Notification
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
    
        var model = SingletonModelDB.sharedInstance.arrayOfPlaylistItems[indexPath.row];
        cell.title.text = model.title;
        
        if (model.image == nil) {
            if let checkedUrl = NSURL(string: model.imageUrl)
            {
                downloadImage(checkedUrl,row: indexPath.row)
            }
            cell.imageview.image = UIImage(named: "placeholder");
        }
        else
        {
            cell.imageview.image = model.image!;
        }
        
        cell.name.text = model.name;
        return cell
    }
    
    func downloadImage(url:NSURL,row:Int){
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {

                SingletonModelDB.sharedInstance.arrayOfPlaylistItems[row].image = UIImage(data: data!);
                //self.tableView.reloadData();
                // If you dont want want to see the placeholder image, then uncomment this line,
            }
        }
    }
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
 
}

