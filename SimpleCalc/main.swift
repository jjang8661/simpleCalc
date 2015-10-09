//
//  main.swift
//  SimpleCalc
//
//  Created by seowoosuk on 10/8/15.
//  Copyright © 2015 Woosuk Seo. All rights reserved.
//

import Foundation

print("Enter an expression separated by returns:")

// Standard input reading
func input() -> String {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    let result = NSString(data: inputData,encoding:NSUTF8StringEncoding) as! String
    return result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}

//Strings -> numbers
func convert(incoming:String) -> Int {
    return NSNumberFormatter().numberFromString(incoming)!.integerValue
}

var numStack = [String]()


func operate(num1:Int,oper:String,num2:Int) -> Double {
    
    let num1 = Double(num1)
    let num2 = Double(num2)
    
    switch oper {
     case "+":
       return num1+num2
     case "-":
       return num1-num2
     case "/":
       return num1/num2
     case "*":
       return num1*num2
    default:
       return 0.0
    }
}

func checkInput(x:String) {
    if(!numStack.isEmpty){
        switch x {
        case "+","-","/","*":
            numStack.append(x)
            checkInput(input())
        default :
            let ope = numStack.removeLast()
            let num1 = convert(numStack.removeLast())
            let result = operate(num1,oper:ope,num2:convert(x))
            print(result)
        }
    } else {
        numStack.append(x)
        checkInput(input())
    }
}


func inputAvg(values : [String])->Double{
    var total = 0.0
    for value in values {
        total += Double(convert(value))
    }
    return total/Double(values.count)
}

func inputFact(value : Int) -> Int {
    var fact = 1
    var num = value
    while(num != 0) {
        fact *= num
        num--
    }
    return fact
}

var inputArr = input().componentsSeparatedByString(" ")

if (inputArr.count > 1) {
    if(inputArr.last == "count"){
        inputArr.removeLast()
        print("\(inputArr.count)")
    } else if(inputArr.last) == "avg" {
        inputArr.removeLast()
        print("\(inputAvg(inputArr))")
    } else if(inputArr.last) == "fact" {
        inputArr.removeLast()
        print("\(inputFact(convert(inputArr[0])))")
    } else {
        print("Not valid")
    }
} else {
checkInput(inputArr[0])
}


