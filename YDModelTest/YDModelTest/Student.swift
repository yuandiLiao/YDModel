//
//  student.swift
//  YDModelTest
//
//  Created by 廖源迪 on 2017/8/22.
//  Copyright © 2017年 yuandiLiao. All rights reserved.
//

import UIKit

class Student: NSObject {
    var name:String?
    var age = 0
    
    override internal var description: String {
        return "{  student.age:\(age) student.name:\(name)}"
    }

}
