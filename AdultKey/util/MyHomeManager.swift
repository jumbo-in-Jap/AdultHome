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
        self.addPrimaruHome()
    }
    
    func addPrimaruHome()
    {
        self.addHomeWithName("myHome",
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
        if(manager.homes.count > 0){
            self.isEnable = true
            NSLog("Primary home is %@", manager.primaryHome.name)
            var notif:NSNotification = NSNotification(name: NOTIF_MYHOME_UPDATE, object: nil)
            NSNotificationCenter.defaultCenter().postNotification(notif)
            
            for i in 0...self.homes.count{NSLog("homes:%@", self.homes[i].name)}
        }
    }
    
    func homeManagerDidUpdatePrimaryHome(manager: HMHomeManager!)
    {
    }
}
