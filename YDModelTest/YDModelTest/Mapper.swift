//
//  Mapper.swift
//  YDModelTest
//
//  Created by 廖源迪 on 2017/8/25.
//  Copyright © 2017年 yuandiLiao. All rights reserved.
//

import UIKit

class Mapper: NSObject {
    var mapperString:String?
    var mapperInt = 0
    var mapperClass:Student?
    var mapperModelArray:Array<School>?
    
    override class func keyMapper() -> [String:String] {
        return ["mapperString":"string",
                "mapperInt":"int",
                "mapperClass":"student",
                "mapperModelArray":"arrModel"]
    }
    override class func objectClassMapper() -> [String:String] {
        return ["mapperModelArray":"School"]
    }

    override internal var description: String {
        return "{ mapperString: \(mapperString)  mapperInt:\(mapperInt) mapperClass:\(mapperClass) mapperModelArray:\(mapperModelArray)}"
    }
}
