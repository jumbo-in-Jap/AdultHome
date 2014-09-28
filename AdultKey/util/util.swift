//
//  util.swift
//  goodHome
//
//  Created by 羽田 健太郎 on 2014/09/21.
//  Copyright (c) 2014年 me.jumbeeee.ken. All rights reserved.
//

import UIKit
import HomeKit

let NOTIF_MYHOME_UPDATE = "myhome_update"


enum TYPE_USER_ACTION{
    case normal, light, adult
}

class util: NSObject {
    class func showConfirm(title:String!, message:String!)
    {
        var alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let otherAction = UIAlertAction(title: "OK", style: .Default) {
            action in
        }
        alertController.addAction(otherAction)
        //presentViewController(alertController, animated: true, completion: nil)
    }
    class func getCharctersticName(type:String)->String
    {
    var res:String
        switch type{
        case HMCharacteristicTypePowerState: res = "PowerState"
        case HMCharacteristicTypeObstructionDetected: res = "ObstructionDetected"
        case HMCharacteristicTypeIdentify: res = "Identify"
        case HMCharacteristicTypeOutletInUse: res = "OutletInUse"
        case HMCharacteristicTypeAudioFeedback: res = "AudioFeedback"
        case HMCharacteristicTypeAdminOnlyAccess: res = "AdminOnlyAccess"
        case HMCharacteristicTypeMotionDetected: res = "MotionDetected"
            
        case HMCharacteristicTypeHue: res = "Hue"
        case HMCharacteristicTypeSaturation: res = "Saturation"
        case HMCharacteristicTypeCurrentTemperature: res = "CurrentTemperature"
        case HMCharacteristicTypeTargetTemperature: res = "TargetTemperature"
        case HMCharacteristicTypeCoolingThreshold: res = "CoolingThreshold"
        case HMCharacteristicTypeHeatingThreshold: res = "HeatingThreshold"
        case HMCharacteristicTypeCurrentRelativeHumidity: res = "CurrentRelativeHumidity"
        case HMCharacteristicTypeTargetRelativeHumidity: res = "TargetRelativeHumidity"
        case HMCharacteristicTypeRotationSpeed: res = "RotationSpeed"
            
        case HMCharacteristicTypeBrightness: res = "Brightness"
        case HMCharacteristicTypeTemperatureUnits: res = "TemperatureUnits"
        case HMCharacteristicTypeCurrentDoorState: res = "CurrentDoorState"
        case HMCharacteristicTypeTargetDoorState: res = "TargetDoorState"
        case HMCharacteristicTypeRotationDirection: res = "RotationDirection"
        case HMCharacteristicTypeCurrentLockMechanismState: res = "CurrentLockMechanismState"
        case HMCharacteristicTypeTargetLockMechanismState: res = "TargetLockMechanismState"
        case HMCharacteristicTypeLockMechanismLastKnownAction: res = "LockMechanismLastKnownAction"
    
        case HMCharacteristicTypeName: res = "Name"
        case HMCharacteristicTypeManufacturer: res = "Manufacture"
        case HMCharacteristicTypeModel: res = "Model"
        case HMCharacteristicTypeSerialNumber: res = "Serial"
        case HMCharacteristicTypeVersion: res = "Version"
            
        default: res = "unknown"
        }
        return res
    }
    
    class func userAction(actionType:TYPE_USER_ACTION)
    {
        switch (actionType)
        {
            case .normal:
                println("normal")
                self.actionNormal()
            
            case .light:
                println("light")
                self.actionLight()
            
            case .adult:
                println("adult")
                self.actionAdult()

            default:
                println("def")
        }
    }
    
    class func actionNormal()
    {
        //self.addAccessory()
        var myhome:HMHome = MyHomeManager.sharedInstance.primaryHome
        var myhomeAccessories:[HMAccessory] = myhome.accessories as [HMAccessory]

        for accessory in myhomeAccessories
        {
            //NSLog("Accessory name : %@", accessory.name) // accessroy name は更新されない
            if(accessory.name == "testAccessroy")
            {
                accessory.identifyWithCompletionHandler(
                    {(acc_err:NSError!)->Void in
                        if (acc_err == nil)
                        {
                            var myhomeActions:[HMActionSet] = myhome.actionSets as [HMActionSet]
                            var myhomeServices:[HMService] = myhomeAccessories[0].services as [HMService]
                            
                            for service:HMService in myhomeServices
                            {
                                //NSLog("s - %@", service.name)
                                if(service.name == "Lock")
                                {
                                    for characteristic:HMCharacteristic in service.characteristics as [HMCharacteristic]
                                    {
                                        NSLog("type %@", self.getCharctersticName(characteristic.characteristicType))
                                        NSLog(" c - %@", characteristic.metadata)
                                        if(characteristic.characteristicType == HMCharacteristicTypeTargetLockMechanismState)
                                        {
                                            characteristic.writeValue(1.0,
                                                completionHandler:
                                                {(err:NSError!)->Void in
                                                    if(err == nil)
                                                    {   println("open")
                                                    }else{
                                                        println("Faled to use characteristic \(err)")
                                                    }
                                            })
                                        }
                                    }
                                }
                            }
                        }else{
                            println("Faled to use Accessory \(acc_err)")
                        }
                }
                )
                
            }
        }
    }

    class func actionLight()
    {
        
    }

    class func actionAdult()
    {
        
    }

}
