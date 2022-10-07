//
//  ViewDataController.swift
//  Homework1
//
//  Created by Richard Marquez on 4/9/22.
//

import UIKit

class ViewDataController: UIViewController
{
    @IBOutlet weak var systolicLabel: UILabel!
    @IBOutlet weak var diastolicLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var symptomsLabel: UILabel!
    @IBOutlet weak var weekdayControl: UISegmentedControl!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let selectedIndex = weekdayControl.selectedSegmentIndex
        if(Health.shared.HealthConditions[selectedIndex] != nil)
        {
            systolicLabel.text = String(Health.shared.HealthConditions[selectedIndex]!.systolicPressure!)
            diastolicLabel.text = String(Health.shared.HealthConditions[selectedIndex]!.diastolicPressure!)
            weightLabel.text = String(Health.shared.HealthConditions[selectedIndex]!.weight!)
            sugarLabel.text = String(Health.shared.HealthConditions[selectedIndex]!.morningSugarLevel!)
            symptomsLabel.text = String(Health.shared.HealthConditions[selectedIndex]!.symptoms!)
        }
        else
        {
            systolicLabel.text = "No Data."
            diastolicLabel.text = "No Data."
            weightLabel.text = "No Data."
            sugarLabel.text = "No Data."
            symptomsLabel.text = "No Data."
        }
    }
    @IBAction func updateLabels(_ sender: Any)
    {
        let selectedIndex = weekdayControl.selectedSegmentIndex
        if(Health.shared.HealthConditions[selectedIndex] != nil)
        {
            systolicLabel.text = String(Health.shared.HealthConditions[selectedIndex]!.systolicPressure!)
            diastolicLabel.text = String(Health.shared.HealthConditions[selectedIndex]!.diastolicPressure!)
            weightLabel.text = String(Health.shared.HealthConditions[selectedIndex]!.weight!)
            sugarLabel.text = String(Health.shared.HealthConditions[selectedIndex]!.morningSugarLevel!)
            symptomsLabel.text = String(Health.shared.HealthConditions[selectedIndex]!.symptoms!)
        }
        else
        {
            systolicLabel.text = "No Data."
            diastolicLabel.text = "No Data."
            weightLabel.text = "No Data."
            sugarLabel.text = "No Data."
            symptomsLabel.text = "No Data."
        }
    }
    
}
