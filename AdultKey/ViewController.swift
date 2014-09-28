//
//  ViewController.swift
//  AdultKey
//
//  Created by 羽田 健太郎 on 2014/09/28.
//  Copyright (c) 2014年 me.jumbeeee.ken. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        MyHomeManager.sharedInstance
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"getUpdateHome", name: NOTIF_MYHOME_UPDATE, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - get notification
    func getUpdateHome()
    {
        if(!MyHomeManager.sharedInstance.isEnable)
        {
            self.performSegueWithIdentifier("setHome", sender: nil)
        }
    }

    // MARK: - actions
    @IBAction func openNromal()
    {
        util.userAction(TYPE_USER_ACTION.normal)
    }
    
    @IBAction func openLight()
    {
        util.userAction(TYPE_USER_ACTION.light)
    }

    @IBAction func openAdult()
    {
        util.userAction(TYPE_USER_ACTION.adult)
    }
    
    // MARK: - prepare segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "push_accessory_view")
        {
        }
    }
    
    @IBAction func destroyHome()
    {
        MyHomeManager.sharedInstance.destroyAllHome()
        self.performSegueWithIdentifier("setHome", sender: nil)        
    }


    @IBAction func showAccessoryView()
    {
        self.performSegueWithIdentifier("push_accessory_view", sender: nil)
    }

}

