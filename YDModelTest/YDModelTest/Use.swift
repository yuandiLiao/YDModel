//
//  Use.swift
//  YDModelTest
//
//  Created by 廖源迪 on 2017/8/22.
//  Copyright © 2017年 yuandiLiao. All rights reserved.
//

import UIKit

class Use: NSObject {

    var name:String?
    var url:NSURL?
    var age = 0
    var boolValue:Bool = false
    var intValue:Int64 = 0
    var nsinter:NSInteger = 0
    var doubleValue:Double = 0
    var floatValue:Float = 0
    var floatValue1:Float32 = 0
    var floatValue2:Float64 = 0
    var numberValue:NSNumber = 0
    var int64:Int64 = 4444
    var dic:NSDictionary?
    var arr:NSArray?
    
    var sel:Selector?
    var iva:Ivar?
    var cla:Method?
    
    //    var int8:Int8 = 111
    //    var int16:Int16 = 111
    //    var int32:Int32 = 3333
    //  var arrModel:Array<Student>?
    //    var uIntV:uint = 11
    //    var uInt8:UInt8 = 222
    //    var uInt16:UInt16 = 3333
    //    var uInt32:UInt32 = 4444
    //    var uInt64:UInt64 = 5555

    override internal var description: String {
        return "{ name: \(name)  url:\(url) age:\(age) boolValue:\(boolValue) intValue:\(intValue) nsinter:\(nsinter) doubleValue:\(doubleValue) floatValue:\(floatValue) numberValue\(numberValue) dic:\(dic) arr:\(arr)}"
    }
}
