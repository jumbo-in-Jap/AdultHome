//
//  AccessoriesTableViewController.swift
//  goodHome
//
//  Created by 羽田 健太郎 on 2014/09/21.
//  Copyright (c) 2014年 me.jumbeeee.ken. All rights reserved.
//

import UIKit
import HomeKit

// 操作対象の取得
class AccessoriesTableViewController: UITableViewController,HMAccessoryBrowserDelegate {
    var accessoryBrowser:HMAccessoryBrowser = HMAccessoryBrowser()
    var addedAccessories = [HMAccessory]()
    var findAccessories = [HMAccessory]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addedAccessories = MyHomeManager.sharedInstance.primaryHome.accessories as [HMAccessory]
        self.accessoryBrowser.delegate = self;
        self.accessoryBrowser.startSearchingForNewAccessories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var res:Int = 0
        if section == 0
        {
            res = self.addedAccessories.count
        }else{
            res = self.findAccessories.count
        }
        return res
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var res:String = ""
        if section == 0
        {
            res = "added"
        }else{
            res = "new"
        }
        return res
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.section) == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = self.addedAccessories[indexPath.row].name
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = self.findAccessories[indexPath.row].name
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if(indexPath.section == 1)
        {
            var targetAccessory:HMAccessory = self.findAccessories[indexPath.row]
            var alertController = UIAlertController(title: "Confirm add Accessory", message: "Add to your home?", preferredStyle: .Alert)
            
            let otherAction = UIAlertAction(title: "OK", style: .Default) {
                action in
                // 捜査対象の追加
                MyHomeManager.sharedInstance.primaryHome.addAccessory(targetAccessory,
                    completionHandler: {(err:NSError!) -> Void in
                        if(err != nil)
                        {
                            self.findAccessories.removeAtIndex(indexPath.row)
                            self.addedAccessories.append(targetAccessory)
                            self.tableView.reloadData()
                        }else{
                            println("Failed to add Accessory \(err)")
                        }
                })
            }
            let cancelAction = UIAlertAction(title: "NO", style: .Cancel) {
                action in
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(otherAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
    }

    // - accessory browser delegate
    func accessoryBrowser(browser: HMAccessoryBrowser!, didFindNewAccessory accessory: HMAccessory!)
    {
        
        /*
        NSLog("%@", accessory.identifier)
        NSLog("%@", accessory.reachable)
        NSLog("%@", accessory.bridged)
        NSLog("%@", accessory.blocked)
        NSLog("%@", accessory.identifier)
        NSLog("%@", accessory.services)
        */
        if !contains(self.findAccessories, accessory) && !contains(MyHomeManager.sharedInstance.primaryHome.accessories as [HMAccessory], accessory)
        {
            self.findAccessories.append(accessory)
            NSLog("Add Accessory %@", accessory.name)
        }
        self.tableView.reloadData()
    }
    
    func accessoryBrowser(browser: HMAccessoryBrowser!, didRemoveNewAccessory accessory: HMAccessory!)
    {
        
    }

}
