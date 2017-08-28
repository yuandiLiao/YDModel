# YDModel 
## swift模型解析
支持swift3.0 \
支持String Dictionary Array URL Bool Int64 NSInteger Double Float NSNumber等数据类型解析\
支持内嵌模型和内嵌模型数组解析，支持映射\
暂时不支持Int8 Int16 Int32 uint UInt8 UInt16 UInt32类型
### 使用时需注意
声明基本数据类型如int等时，需要实例化如 var intValue:Int = 0,不能直接 var intValue:Int? ，不然获取不到该属性

#### 使用cocoapods导入
```
pod 'YDModel'
```

#### 手动导入
下载工程中的YDModel文件，将其拖入工程中

### 1.基本的字典转model
字典
```swift
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
                    ["name":"嘻嘻3","age":404]]] 
```

model
```swift
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
    }
```
解析转换
```swift
  let use = Use.modelWithDic(dic: dic as Dictionary<String, AnyObject>) as! Use
```

### 2.内嵌模型和内嵌数组模型字典转model
字典
```swift
 let dic = ["schoolName":"深圳大学",
                  "place":"深圳",
                  "schoolAge":"32",
                  "student":["name":"嘻嘻","age":40],
                  "arrModel":[
                    ["name":"嘻嘻1","age":401],
                    ["name":"嘻嘻2","age":403],
                    ["name":"嘻嘻3","age":404]]]
```
model
```swift
class School: NSObject {
    var schoolName:String?
    var place:String?
    var schoolAge = 0
    var student:Student?
    var arrModel:Array<Student>?
    
    override class func objectClassMapper() -> [String:String] {
        return ["arrModel":"Student"]
    }
}

class Student: NSObject {
    var name:String?
    var age = 0
}
```
解析转换
```swift
let school = School.modelWithDic(dic: dic as Dictionary<String, AnyObject>) as! School
```
### 3.映射
使用映射时需要在model中重写下面两个方法，自己选用
```swift
//内嵌数组模型映射[propertyName:key]
    class func objectClassMapper() -> [String:String] {
        return [:]
    }
    //key映射[propertyName:claName]
    class func keyMapper() -> [String:String] {
        return [:]
    }
```

字典
```swift
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
                        ["name":"嘻嘻3","age":404]]]]]
```

model
```swift
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
}

class School: NSObject {
    var schoolName:String?
    var place:String?
    var schoolAge = 0
    var student:Student?
    var arrModel:Array<Student>?
   
    override class func objectClassMapper() -> [String:String] {
        return ["arrModel":"Student"]
    }
}

class Student: NSObject {
    var name:String?
    var age = 0
}

```
解析转换
```swift
 let mapper = Mapper.modelWithDic(dic: dic as Dictionary<String, AnyObject>)
```

### 4.数组模型
字典
```swift
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
```
model
```swift
class Student: NSObject {
    var name:String?
    var age = 0
}

```
解析转换
```swift
let modelArray = Student.modelWithArray(array: array as Array<AnyObject>) as! Array<Student>
```


#### 有什么问题欢迎issue或者联系我： 15019483722@163.com
