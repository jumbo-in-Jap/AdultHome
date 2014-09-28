//
//  MyHomeManager.swift
//  goodHome
//
//  Created by 羽田 健太郎 on 2014/09/21.
//  Copyright (c) 2014年 me.jumbeeee.ken. All rights reserved.
//

import UIKit
import HomeKit

class MyHomeManager: HMHomeManager, HMHomeManagerDelegate{
    var isEnable:Bool = false
    class var sharedInstance : MyHomeManager! {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : MyHomeManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = MyHomeManager()
        }
        return Static.instance!
    }
    
    override init()
    {
        super.init()
        self.delegate = self
    }
    
    func addPrimaruHome(name:String!)
    {
        SVProgressHUD.show()
        self.addHomeWithName(name,
            completionHandler: { (home:HMHome!,err:NSError!)->Void in
                if((err) != nil)
                {
                    println("Failed to build home \(err)")
                    // is not supported
                    if(err.code == 47)
                    {
                        
                    }
                }else{
                    println("add home")
                }
            }
        )
    }
    
    func destroyAllHome()
    {
        var homes:[HMHome] = self.homes as [HMHome]
        NSLog("delete target home:%d", homes.count)
        for home:HMHome in homes
        {
            self.removeHome(home,
                completionHandler: {(err:NSError!) -> Void in
                    if(err == nil)
                    {
                        println("remove home err")
                    }
            })
        }
    }
    
    // - homekit manager delegate
    func homeManager(manager: HMHomeManager!, didAddHome home: HMHome!)
    {
    }
    
    func homeManager(manager: HMHomeManager!, didRemoveHome home: HMHome!)
    {
    }
    
    // homeeは10件まで
    // アプリケーション内のhomeが装填される
    func homeManagerDidUpdateHomes(manager: HMHomeManager!)
    {
        self.successSetHome()
    }
    
    func homeManagerDidUpdatePrimaryHome(manager: HMHomeManager!)
    {
        self.successSetHome()
    }
    
    func successSetHome()
    {
        if(self.homes.count > 0){
            self.isEnable = true
            NSLog("Set primary home is %@", self.primaryHome.name)
        }
        var notif:NSNotification = NSNotification(name: NOTIF_MYHOME_UPDATE, object: nil)
        NSNotificationCenter.defaultCenter().postNotification(notif)
        SVProgressHUD.dismiss()
    }
}
