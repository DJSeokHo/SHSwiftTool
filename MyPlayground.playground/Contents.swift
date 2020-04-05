import UIKit

// basic parameter
// - var let and type
var intNumber: Int
intNumber = 5
print("var intNumber is \(intNumber)")

let doubleNumber: Double = 1.0
print("let doubleNumber is \(doubleNumber)")

let helloString: String = "hello"
var worldString: String
worldString = ", World"

let helloWorldString = helloString + worldString
print(helloWorldString)
print(helloWorldString.uppercased())
print(helloWorldString.lowercased())

// control condition
// - if else

let getUpTime = 6

if(getUpTime == 6) {
    print("good")
}
else {
    print("bad")
}

// - switch
switch (getUpTime) {
    case 6:
        print("good")
    
    default:
        print("bad")
}

// - swith range
// - ... is comparison operator(运算子)，表范围
var number: Int
number = -1

switch (number) {
    case 10000...:
        print("lot of")
        
    case 5000...9999:
        print("many")
    
    case 0...4999:
        print("little")
        
    default:
        print("er...")
}

// array <Type> or array<Any>
var stringArray: Array<Any>

// - init array
stringArray = []

let oneString = "one"
let twoInt = 2
let threeDouble = 3.0
stringArray.append(oneString)
stringArray.append(twoInt)
stringArray.append(threeDouble)

print(stringArray[0])

// - for with index in range
for index in 0...stringArray.count - 1 {
    print(stringArray[index])
}

// - just for - in
for item in stringArray {
    print(item)
}

// - clear array
stringArray.removeAll()
print(stringArray.count)

// dictionary
var keyValueDictionary: Dictionary<String, Any>

// - init
keyValueDictionary = [:]
print(keyValueDictionary.count)
print(keyValueDictionary.description)

keyValueDictionary["a"] = "one"
keyValueDictionary["b"] = 2
keyValueDictionary["c"] = 3.0

print(keyValueDictionary["a"] ?? "")

for(key, value) in keyValueDictionary {
    print("key is \(key) and value is \(value)")
}

keyValueDictionary.removeAll()
print(keyValueDictionary.count)
print(keyValueDictionary.description)
