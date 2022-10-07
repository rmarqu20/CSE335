//
//  HealthConditionModel.swift
//  Homework1
//
//  Created by Richard Marquez on 4/9/22.
//

import Foundation

class Health
{
    static let shared = Health()
    //var emptyHealthCondition = HealthCondition(sp: 0, dp: 0, w: 0.0, msl: 0, s: "No Data")
    var HealthConditions = [HealthCondition?](repeating: nil, count: 7)
    
    var previous:HealthCondition? = nil
    var current:HealthCondition? = nil
    
    init()
    {
        
    }
    
    func getHealthCondition(index:Int) -> HealthCondition
    {
        return HealthConditions[index]!
    }
    
    func addHealthCondition(systolic:Double, diastolic:Double, weight:Double, sugar:Double, symptom:String, index:Int)
    {
        let health = HealthCondition(sp: systolic, dp: diastolic, w: weight, msl: sugar, s: symptom)
        HealthConditions.remove(at: index)
        HealthConditions.insert(health, at: index)
    }
    
    func checkWeight() -> Int
    {
        for health in HealthConditions
        {
            if(health == nil)
            {
                return 2
            }
        }
        let first = (HealthConditions[0]?.weight)! + (HealthConditions[1]?.weight)! + (HealthConditions[2]?.weight)!
        print("first weight total: \(first)")
        print("first weight avg: \(first/3)")
        let second = (HealthConditions[3]?.weight)! + (HealthConditions[4]?.weight)! + (HealthConditions[5]?.weight)! + (HealthConditions[6]?.weight)!
        print("second weight total: \(second)")
        print("second weight avg: \(second/4)")
        if(second/4 > first/3)
        {
            return 1
        }
        return 0
    }
    
    func checkSugar() -> Int
    {
        if(Health.shared.previous == nil || Health.shared.current == nil)
        {
            return 2
        }
        
        let currentSugar = (Health.shared.current?.morningSugarLevel)!
        let previousSugar = (Health.shared.previous?.morningSugarLevel)!        
        if(currentSugar > (previousSugar * 1.1))
        {
            return 1
        }
        return 0
    }
    
    func checkBlood() -> Int
    {
        if(Health.shared.previous == nil || Health.shared.current == nil)
        {
            return 2
        }
        
        let currentBlood = (Health.shared.current?.systolicPressure)!
        let previousBlood = (Health.shared.previous?.systolicPressure)!
        if(currentBlood > (previousBlood * 1.1))
        {
            return 1
        }
        return 0
    }
}

class HealthCondition
{
    var systolicPressure:Double?
    var diastolicPressure:Double?
    var weight:Double?
    var morningSugarLevel:Double?
    var symptoms:String?
    
    init(sp: Double, dp:Double, w: Double, msl: Double, s: String)
    {
        self.systolicPressure = sp
        self.diastolicPressure = dp
        self.weight = w
        self.morningSugarLevel = msl
        self.symptoms = s
    }
}
