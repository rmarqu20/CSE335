//
//  EnterDataController.swift
//  Homework1
//
//  Created by Richard Marquez on 4/9/22.
//

import UIKit

class EnterDataController: UIViewController
{
    @IBOutlet weak var systolicPressureField: UITextField!
    @IBOutlet weak var diastolicPressureField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var sugarField: UITextField!
    @IBOutlet weak var symptomsField: UITextField!
    @IBOutlet weak var weekdayControl: UISegmentedControl!
    @IBOutlet weak var progressView: UIProgressView!
    
    var count = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let count2 = Health.shared.HealthConditions.filter({$0 != nil}).count
        progressView.progress = Float(count2) * (1/7)

    }
    @IBAction func setHealthData(_ sender: Any)
    {
        let selectedIndex = weekdayControl.selectedSegmentIndex
        let systolic = Double(systolicPressureField.text!) ?? 0.0
        let diastolic = Double(diastolicPressureField.text!) ?? 0.0
        let weight = Double(weightField.text!) ?? 0.0
        let sugar = Double(sugarField.text!) ?? 0.0
        let symptom = symptomsField.text! ?? "No Data."
        
        Health.shared.addHealthCondition(systolic: systolic, diastolic: diastolic, weight: weight, sugar: sugar, symptom: symptom, index: selectedIndex)
        
        if(Health.shared.current == nil)
        {
            Health.shared.current = Health.shared.HealthConditions[selectedIndex]
        }
        else
        {
            Health.shared.previous = Health.shared.current
            Health.shared.current = Health.shared.HealthConditions[selectedIndex]
        }
        print("Previous Blood Pressure: \(Health.shared.previous?.systolicPressure)")
        print("Current Blood Pressure: \(Health.shared.current?.systolicPressure)")
        print("Previous Sugar Level: \(Health.shared.previous?.morningSugarLevel)")
        print("Current Sugar Level: \(Health.shared.current?.morningSugarLevel)")
        
        for health in Health.shared.HealthConditions
        {
            count = Health.shared.HealthConditions.filter({$0 != nil}).count
        }
        
        progressView.progress = Float(count) * (1/7)
        print("Count: \(count)")
        print("Progress: \(progressView.progress)/1.0")
        print("Index: \(selectedIndex)")
        systolicPressureField.text = ""
        diastolicPressureField.text = ""
        weightField.text = ""
        sugarField.text = ""
        symptomsField.text = ""
    }
}
