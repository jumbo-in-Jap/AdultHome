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
}
