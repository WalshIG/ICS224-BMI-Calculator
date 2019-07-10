//
//  BMI.swift
//  Project_224
//
//

import Foundation

/// BMI class having two double variables of height and weight.
class Bmi {
    var height:Double
    var weight:Double
    
    /// To initialize height and weight
    init (height:Double, weight:Double) {
        self.height=height
        self.weight=weight
    }
    
    /// BMI function to get the result of the calculation. 
    func bmi()->Double {
        
        let result = weight / ((height/100) * (height/100))
        
        if (result <= 18.5){
            print ("You are underweight!")
        } else if (result <= 24.9) {
            print ("Your have a normal weight!")
        } else if (result <= 29.9){
            print ("You are overweight!")
        } else if (result > 29.9){
            print ("You are obese!")
        } else {
            print ("Invalid Number")
        }
        
        return (result)
    }
}
