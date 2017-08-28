//
//  NSObject_YDModelExtension.swift
//  YDModelTest
//
//  Created by 廖源迪 on 2017/8/22.
//  Copyright © 2017年 yuandiLiao. All rights reserved.
//

import Foundation

extension NSObject{
    
    typealias PropertiesEnumeration = (_ property:YDProperty)->()
    
    class func modelWithDic(dic:Dictionary<String,AnyObject>) -> AnyObject {
        let model = self.init()
        self.enumeraterProperties { (property) in
          model.setVauleWithDic(dic: dic,property: property)
        }
        return model
    }
    class func modelWithArray(array:Array<AnyObject>) -> Array<AnyObject> {
        var modelArr = Array<AnyObject>()
        for item in array {
            let model =  self.modelWithDic(dic: item as! Dictionary<String, AnyObject>)
            modelArr.append(model)
        }
        return modelArr
    }
    class func enumeraterProperties(enumeration:PropertiesEnumeration){
        let properties = self.getPropertes()
        if (properties?.count)! > 0 {
            for property in properties! {
                enumeration(property as! NSObject.YDProperty)
            }
        }
    }
    func setVauleWithDic(dic:Dictionary<String,AnyObject>,property:YDProperty) {
            if (property.type?.isUserDefined) == true {
                if let dicModel = dic[property.key!] {
                    self.setValue(property.type?.typeClass?.modelWithDic(dic: dicModel as! Dictionary<String, AnyObject>), forKey: property.name!)
                }
            }else{
                if let value = dic[property.key!]{
                    if property.type?.code == YDPropertyTypeString || property.type?.code == YDPropertyTypeNSMutableString {
                        if NSStringFromClass(value.classForCoder)
                            == YDPropertyTypeString {
                            self.setValue(value, forKey: property.name!)
                        }else{
                            self.setValue(value.stringValue, forKey: property.name!)
                        }
                    }else if property.type?.isNumber == true{
                        self.setValue(value, forKey: property.name!)
                    }
                    else if property.type?.code == YDPropertyTypeNSDictionary {
                        self.setValue(value as! NSDictionary, forKey: property.name!)
                    }else if  property.type?.code == YDPropertyTypeNSMutableDictionary{
                        self.setValue(value as! NSMutableDictionary, forKey: property.name!)
                    }else if property.type?.code == YDPropertyTypeNSURL{
                        self.setValue(URL(string: value as! String) , forKey: property.name!)
                    }else if property.type?.code == YDPropertyTypeNSArray || property.type?.code == YDPropertyTypeNSMutableArray{
                        print(NSStringFromClass((property.type?.arrayClass)!))
                        if NSStringFromClass((property.type?.arrayClass)!) == "NSObject" {
                           self.setValue(value, forKey: property.name!)
                        }else{
                           self.setValue(property.type?.arrayClass?.modelWithArray(array:value as! Array<AnyObject>), forKey: property.name!)
                        }
                    }
                }
            }
    }
    
    class func getPropertes() -> [AnyObject]? {
        if NSStringFromClass(self) == "NSObject" {
            return nil
        }
        var count:UInt32 = 0
        var propertiesArray = Array<AnyObject>()
        let properties = class_copyPropertyList(self.classForCoder(), &count)
        let superProperties = (self.superclass() as! NSObject.Type).getPropertes()
        if let _ = superProperties {
            propertiesArray += superProperties!
        }
        for i in 0 ..< Int(count) {
            let proerty = properties?[i]
            let ydProperty = YDProperty( property: proerty!)
            //获取key映射
            if let keyName = self.keyMapper()[ydProperty.name!]{
                ydProperty.key = keyName
            }
            //判断是否是数组，要获取到数组里面自定义的类
            if ydProperty.type?.code == YDPropertyTypeNSMutableArray || ydProperty.type?.code == YDPropertyTypeNSArray {
                if let claName = self.objectClassMapper()[ydProperty.name!] {
                    ydProperty.type?.arrayClass = ydProperty.type?.getClassWitnClassNmae(name: claName)
                }else{
                    ydProperty.type?.arrayClass = NSObject.classForCoder()
                }
            }
            propertiesArray.append(ydProperty)
        }
        free(properties)
        return propertiesArray
    }
    //内嵌数组模型映射[propertyName:key]
    class func objectClassMapper() -> [String:String] {
        return [:]
    }
    //key映射[propertyName:claName]
    class func keyMapper() -> [String:String] {
        return [:]
    }
    class YDProperty: NSObject {
        
        //属性
        var proterty:objc_property_t?
        //属性名字
        var name:String?
        //dic里面的key
        var key:String?
        //type
        var type:YDType?
        
        init(property:objc_property_t) {
            super.init()
            self.proterty = property
            self.name = String(cString: property_getName(property))
            self.key = self.name
            let attrs  = NSString(cString: property_getAttributes(property), encoding: String.Encoding.utf8.rawValue)
            let loc = 1;
            var code:String?
            if (attrs?.contains(","))! {
                let location = attrs?.range(of: ",").location
                code = attrs?.substring(with: NSRange.init(location: loc, length: location!-loc))
            }else{
                code = attrs?.substring(from: loc)
            }
            self.type = YDType(code: code!)
        }
    }
    
    class YDType: NSObject {
        
        //属性的类型
        var code:String?
        //是否为基本数据类型,默认不是，初始化时候判断
        var isNumber:Bool = false
        //是否为自定义的类型
        var isUserDefined:Bool?
        //类的类型
        var typeClass:AnyClass?
        //数组模型的类
        var arrayClass:AnyClass?
        
        var numberType:Bool?
        init(code:String) {
            super.init()
            self.code = code
            if(code.characters.count > 3 && code.hasPrefix("@\"")){
                self.code = (code as NSString).substring(with: NSRange(location: 2, length: code.characters.count-3))
            }
            //自定义的类的Types格式为T@"_TtC15字典转模型3Use",N,&,Vuse
            //T+@+"+..+工程的名字+数字+类名+"+,+其他,而我们想要的只是类名，所以要修改这个字符串
            let bundleName = getBundleName()
            if (self.code?.contains(bundleName))!{
              self.isUserDefined = true
                let range = (self.code! as NSString).range(of: bundleName)
                //先把工程名字后面的提取出来
                if range.length > 0 {
                    self.code = (self.code! as NSString).substring(from: range.length + range.location)
                }
                //去掉数字
                var number:String = ""
                for char in (self.code?.characters)! {
                    if char <= "9" && char >= "0"{
                        number += String(char)
                    }else{
                        break
                    }
                }
                let numberRange = (self.code! as NSString).range(of: number)
                if numberRange.length > 0{
                    //得到类名
                    self.code = (self.code! as NSString).substring(from: numberRange.length)
                  }
                 //如果是自定义的类NSClassFromString这个方法传得字符串是工程的名字+类名
                self.typeClass = getClassWitnClassNmae(name: self.code!)
            }
            
            //基本数据类型
            if self.code == YDPropertyTypeInt || self.code == YDPropertyTypeFloat || self.code == YDPropertyTypeDouble  || self.code == YDPropertyTypeNSNumber || self.code == YDPropertyTypeBool {
                self.isNumber = true
            }else{
                self.isNumber = false
            }
        }
        //获取工程的名字
         func getBundleName() -> String{
            var bundlePath = Bundle.main.bundlePath
            bundlePath = bundlePath.components(separatedBy: "/").last!
            bundlePath = bundlePath.components(separatedBy: ".").first!
            return bundlePath
        }
        //通过类名返回一个AnyClass
        func getClassWitnClassNmae(name:String) ->AnyClass?{
            let type = getBundleName() + "." + name
            return NSClassFromString(type)
        }
    }
    
    
}
