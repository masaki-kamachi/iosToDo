//
//  MemoStore.swift
//  SampleNotStoryBoard
//
//  Created by masakikamachi on 2016/06/05.
//  Copyright © 2016年 masakikamachi. All rights reserved.
//

import UIKit
import CoreData

@objc(MemoStore)
class MemoStore: NSManagedObject {
    
    @NSManaged var memo:String
    @NSManaged var date:NSDate
}
