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
    lazy var netman = NetworkManager()
    lazy var viewman = ViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        presentNewButton()
        // Add observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "DataPopulatedNotification:", name:"JsonPopulatesLocalModelAfterANetworkCall", object: nil)
        
        tableView.delegate = self;
        tableView.dataSource = self;

//        netman.performNetworkOps(netman.TopSongsbaseUrl,
//            callback: {
//                    println("Hello world Clousure")
//            });
        
        netman.performNetworkOps(netman.TopSongsbaseUrl, callback: { (j) -> Void in
            self.netman.PopulateModel(j)
        })
        
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self.tableView, selector: Selector("reloadData"), userInfo: nil, repeats: true)
    }
    
    func DataPopulatedNotification(notification: NSNotification){
        self.tableView.reloadData();
    }
    
    deinit
    {
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
                netman.downloadImage(checkedUrl,row: indexPath.row)
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
    
    func presentNewButton()
    {
        var rect = CGRectMake(self.view.frame.width - viewman.AppConsts.buttonWidth - 5, viewman.AppConsts.buttonHeight/2 + 0.0, viewman.AppConsts.buttonWidth, viewman.AppConsts.buttonHeight)
        var newbutton = viewman.giveMeAButton(rect)
        newbutton.addTarget(self, action:"newButtonClickHandler" , forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(newbutton);
    }
    
    func newButtonClickHandler(){
        println("Clicked -> Ready to go")
    }
    
}

