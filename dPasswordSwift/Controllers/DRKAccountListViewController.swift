//
//  ViewController.swift
//  dPasswordSwift
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 com.zendai. All rights reserved.
//

import UIKit

class DRKAccountListViewController: UITableViewController, UIAlertViewDelegate {

    var accounts: NSArray?
    var accountWillShow: DRKAccount?
    var password: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        DRKAccountStore.sharedInstance.addAccountWithAccountName("joseph@gmail.com", username: "", encryptedPassword: <#NSData#>)
        
        self.accounts = DRKAccountStore.sharedInstance.getAllAccounts()
        
        // Do any additional setup after loading the view.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    
    /// Private Methods
    func randomSecureString() -> NSString {
        var random = arc4random() % 5;
        var secureString = NSMutableString()
        for var i = 0; i < 10; i++ {
            secureString.appendString("*")
        }
        return secureString
    }
}
