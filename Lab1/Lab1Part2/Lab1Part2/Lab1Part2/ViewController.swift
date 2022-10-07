//
//  ViewController.swift
//  Lab1Part2
//
//  Created by  on 1/30/22.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var HeightValue: UILabel!
    @IBOutlet weak var WeightValue: UILabel!
    @IBOutlet weak var BMIValue: UILabel!
    @IBOutlet weak var Results: UILabel!
    
    var height: Float = 72;
    var weight: Float = 185;
    
    @IBAction func HeightSlider(_ sender: UISlider, forEvent event: UIEvent)
    {
        HeightValue.text = String(Int(sender.value));
        height = sender.value;
        calculateBMI(height: height, weight: weight);
    }
    
    @IBAction func WeightSlider(_ sender: UISlider, forEvent event: UIEvent)
    {
        WeightValue.text = String(Int(sender.value));
        weight = sender.value;
        calculateBMI(height: height, weight: weight);
    }
    
    func calculateBMI(height: Float, weight: Float)
        {
            let BMI = (weight / (height * height)) * 703;
            BMIValue.text = String(BMI);
            BMIValue.sizeToFit();
            BMIValue.center.x = self.view.center.x;
            Results.isHidden = false;
            if(BMI < 18)
            {
                Results.text = "You are Underdweight...";
                Results.textColor = UIColor.blue;
            }
            else if(BMI < 25 && BMI >= 18)
            {
                Results.text = "You are Normal...";
                Results.textColor = UIColor.green;
            }
            else if(BMI < 30 && BMI >= 25)
            {
                Results.text = "You are Pre-Obese...";
                Results.textColor = UIColor.purple;
            }
            else if(BMI >= 30)
            {
                Results.text = "You are Obese...";
                Results.textColor = UIColor.red;
            }
        }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}
