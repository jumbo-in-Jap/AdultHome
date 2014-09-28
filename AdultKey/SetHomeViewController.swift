//
//  SetHomeViewController.swift
//  AdultKey
//
//  Created by 羽田 健太郎 on 2014/09/28.
//  Copyright (c) 2014年 me.jumbeeee.ken. All rights reserved.
//

import UIKit

class SetHomeViewController: UIViewController {

    @IBOutlet var nameField : UITextField!
    @IBOutlet var setBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"getUpdateHome", name: NOTIF_MYHOME_UPDATE, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setHome()
    {
        
        if self.nameField.text.utf16Count < 1
        {
            return
        }
        
        if let name = self.nameField.text
        {
            MyHomeManager.sharedInstance.addPrimaruHome(name)
        }
    }
    
    func getUpdateHome()
    {
        if MyHomeManager.sharedInstance.isEnable
        {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
