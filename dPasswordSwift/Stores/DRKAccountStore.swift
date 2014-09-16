//
//  DRKAccountStore.swift
//  dPasswordSwift
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 com.zendai. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class DRKAccountStore {
    
    private var _managedObjectContext: NSManagedObjectContext?
    var managedObjectContext: NSManagedObjectContext? {
        get {
            if _managedObjectContext == nil {
                var delegate = UIApplication.sharedApplication().delegate as AppDelegate
                _managedObjectContext = delegate.managedObjectContext
            }
            return _managedObjectContext
        }
        set {
            _managedObjectContext = newValue
        }
    }
    
    private var _accounts: NSMutableArray?
    var accounts: NSMutableArray? {
        get {
            if _accounts == nil {
                _accounts = self.fetchAllAccounts()!.mutableCopy() as? NSMutableArray
            }
            return _accounts
        }
        set {
            _accounts = newValue
        }
    }
    
    /// Public Methods
    
    func getAllAccounts() -> NSArray {
        return self.accounts!
    }
    
    func changePassword(oldPassword: NSString, toNewPassword password: NSString) {
        for var i = 0; i < self.accounts!.count; i++ {
            var account = self.accounts![i] as DRKAccount
            var accountPassword = self.decryptPassword(account.encryptedPassword, withKey: oldPassword)
            var newEncryptedPassword = self.encryptPassword(accountPassword, withKey: password)
            account.encryptedPassword = newEncryptedPassword
        }
        self.save()
    }
    
    func updateAccount() {
        self.save()
    }
    
    func addAccountWithAccountName(accountName: NSString, username: NSString, encryptedPassword: NSData) {
        
        var account = NSEntityDescription.insertNewObjectForEntityForName("DRKAccount", inManagedObjectContext: self.managedObjectContext!) as DRKAccount
        account.accountId = NSUUID.UUID().UUIDString
        account.accountName = accountName
        account.username = username
        account.encryptedPassword = encryptedPassword
        account.dateCreated = NSDate()
        self.managedObjectContext!.insertObject(account)
        self.accounts?.insertObject(account, atIndex: 0)
        self.save()
    }
    
    func deleteAccount(account: DRKAccount) {
        self.managedObjectContext?.deletedObjects
        self.accounts?.delete(account)
        self.save()
    }

    /// Decrypt Password
    
    func decryptPassword(encryptedPassword: NSData, withKey key: NSString) -> NSString {
        var data = encryptedPassword.AES128DecryptWithKey(key, iv: "_23dAOq9")
        return NSString(data: data, encoding: NSUTF8StringEncoding)
    }
    
    func encryptPassword(password: NSString, withKey key: NSString) -> NSData {
        var data = password.dataUsingEncoding(NSUTF8StringEncoding)
        return data!.AES128EncryptWithKey(key, iv: "_23dAOq9")
    }
    
    /// Private Methods
    
    func save() {
        var delegate = UIApplication.sharedApplication().delegate as AppDelegate
        delegate.saveContext()
    }

    
    func fetchAllAccounts() -> NSArray? {
        var request = NSFetchRequest(entityName: "DRKAccount")
        var sortDescriptor = NSSortDescriptor(key: "dateCreate", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        var error: NSError?
        return self.managedObjectContext?.executeFetchRequest(request, error: &error)
    }

    
    /// Singleton
    class var sharedInstance : DRKAccountStore {
        struct Static {
            static let instance : DRKAccountStore = DRKAccountStore()
        }
        return Static.instance
    }
}