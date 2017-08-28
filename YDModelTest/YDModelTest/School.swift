//
//  r.swift
//  YDModelTest
//
//  Created by 廖源迪 on 2017/8/22.
//  Copyright © 2017年 yuandiLiao. All rights reserved.
//

import UIKit

class School: NSObject {
    var schoolName:String?
    var place:String?
    var schoolAge = 0
    var student:Student?
    var arrModel:Array<Student>?
    
    override class func objectClassMapper() -> [String:String] {
        return ["arrModel":"Student"]
    }
    override internal var description: String {
        return "{ schoolName: \(schoolName)  place:\(place) schoolAge:\(schoolAge)] student:\(student) arrModel:\(arrModel)}"
    }
}
