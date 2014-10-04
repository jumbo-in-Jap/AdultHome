//
//  TodayViewController.swift
//  key_widget
//
//  Created by 羽田 健太郎 on 2014/09/28.
//  Copyright (c) 2014年 me.jumbeeee.ken. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 320, height: 100)
        self.preferredContentSize.height = 120.0
        //gradientLayer.frame = self.view.bounds
        //self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    @IBAction func openNromal()
    {
        util.userAction(TYPE_USER_ACTION.normal)
    }
}
