//
//  Math.swift
//  Hapy_Math
//
//  Created by nhp on 2/7/19.
//  Copyright © 2019 nhp. All rights reserved.
//

import Foundation

class Math {
    let operation = ["-","+"]
    
    func createExpression(numberOfMath:Int) -> [String] {
        var expressionAndresult = [String]()
        var result = 0
        for _ in 1...numberOfMath {
            var expression = ""
            var randNumber = arc4random_uniform(9) + 1
            expression.append(String(randNumber))
            result = result + Int(randNumber)
            for _ in 0...6 {
                let operationPosition = Int(arc4random_uniform(2) + 0)
                let randOperation = operation[operationPosition]
                randNumber = arc4random_uniform(9) + 1
                if(randOperation == "-"){
                    result = result - Int(randNumber)
                }
                if(randOperation == "+"){
                    result = result + Int(randNumber)
                }
                expression.append(String(randOperation))
                expression.append(String(randNumber))
                
            }
            expressionAndresult.append(expression)
            expressionAndresult.append(String(result))
            result = 0
        }
        return expressionAndresult
    }
}
