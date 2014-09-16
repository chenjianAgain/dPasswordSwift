//
//  DRKAccount.swift
//  dPasswordSwift
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 com.zendai. All rights reserved.
//

import Foundation
import CoreData

class DRKAccount: NSManagedObject {

    @NSManaged var accountId: String
    @NSManaged var accountName: String
    @NSManaged var dateCreated: NSDate
    @NSManaged var encryptedPassword: NSData
    @NSManaged var username: String

}
