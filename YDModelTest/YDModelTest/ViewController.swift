//
//  ViewController.swift
//  YDModelTest
//
//  Created by 廖源迪 on 2017/8/22.
//  Copyright © 2017年 yuandiLiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fun1()
        fun2()
        fun3()
        fun4()
    }
    //基本的字典转model
    func fun1(){
        let dic = ["intValue":222,
                   "name":"哟哟",
                   "url":"http://baidu.com",
                   "age":"22222",
                   "boolValue":222,
                   "nsinter":222,
                   "doubleValue":222,
                   "floatValue":222,
                   "floatValue1":222,
                   "floatValue2":222,
                   "numberValue":222,
                   "dic":["hah":"哈哈"],
                   "arr":[1,2,3,4,5],
                   "str":["name":"嘻嘻","age":40],
                   "arrModel":[
                    ["name":"嘻嘻1","age":401],
                    ["name":"嘻嘻2","age":403],
                    ["name":"嘻嘻3","age":404]]] as [String : Any]
        
        let use = Use.modelWithDic(dic: dic as Dictionary<String, AnyObject>) as! Use
        print(use)
    }
    
    //内嵌模型和内嵌数组模型字典转model
    func fun2(){
        let dic = ["schoolName":"深圳大学",
                  "place":"深圳",
                  "schoolAge":"32",
                  "student":["name":"嘻嘻","age":40],
                  "arrModel":[
                    ["name":"嘻嘻1","age":401],
                    ["name":"嘻嘻2","age":403],
                    ["name":"嘻嘻3","age":404]]] as [String : Any]
        let school = School.modelWithDic(dic: dic as Dictionary<String, AnyObject>) as! School
        print(school)
    }
    //映射
    func fun3(){
        let dic = ["string":"mapperString",
                   "int":"1111",
                   "student":["name":"嘻嘻","age":40],
                   "arrModel":[
                    ["schoolName":"深圳大学",
                     "place":"深圳",
                     "schoolAge":"32",
                     "student":["name":"嘻嘻","age":40],
                     "arrModel":[
                        ["name":"嘻嘻1","age":401],
                        ["name":"嘻嘻2","age":403],
                        ["name":"嘻嘻3","age":404]]],
                    ["schoolName":"深圳大学",
                     "place":"深圳",
                     "schoolAge":"32",
                     "student":["name":"嘻嘻","age":40],
                     "arrModel":[
                        ["name":"嘻嘻1","age":401],
                        ["name":"嘻嘻2","age":403],
                        ["name":"嘻嘻3","age":404]]],
                    ["schoolName":"深圳大学",
                     "place":"深圳",
                     "schoolAge":"32",
                     "student":["name":"嘻嘻","age":40],
                     "arrModel":[
                        ["name":"嘻嘻1","age":401],
                        ["name":"嘻嘻2","age":403],
                        ["name":"嘻嘻3","age":404]]]]] as [String : Any]
        let mapper = Mapper.modelWithDic(dic: dic as Dictionary<String, AnyObject>)
        print(mapper)
        
    }
    //数组模型
    func fun4(){
        let array = [
            ["name":4444,"age":401],
            ["name":"嘻嘻2","age":403],
            ["name":"嘻嘻3","age":404],
            ["name":"嘻嘻1","age":401],
            ["name":"嘻嘻2","age":403],
            ["name":"嘻嘻3","age":404],
            ["name":"嘻嘻1","age":401],
            ["name":"嘻嘻2","age":403],
            ["name":"嘻嘻3","age":404]]
        
         let modelArray = Student.modelWithArray(array: array as Array<AnyObject>) as! Array<Student>
        for item in modelArray {
            print(item)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

