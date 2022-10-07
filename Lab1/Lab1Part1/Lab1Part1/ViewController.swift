//
//  ViewController.swift
//  Lab1Part1
//
//  Created by  on 1/26/22.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var Height: UITextField!
    @IBOutlet weak var Weight: UITextField!
    @IBOutlet weak var BMI: UILabel!
    @IBOutlet weak var Results: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    @IBAction func CalculateBMI(_ sender: Any, forEvent event: UIEvent)
    {
        let height = Height.text;
        let weight = Weight.text;
        
        if(height!.isEmpty && weight!.isEmpty)
        {
            BMI.text = "";
            BMI.sizeToFit();
        }
        else
        {
            let calc = Double(weight!)! /
            (Double(height!)! * Double(height!)!) * 730.0;
            let str = String(format: "%f", calc);
            BMI.text = "\(str)";
            BMI.sizeToFit();
            BMI.center.x = self.view.center.x;
            Results.isHidden = false;
            if(calc < 18)
            {
                Results.text = "You are Underdweight...";
                Results.textColor = UIColor.blue;
            }
            else if(calc < 25 && calc >= 18)
            {
                Results.text = "You are Normal...";
                Results.textColor = UIColor.green;
            }
            else if(calc < 30 && calc >= 25)
            {
                Results.text = "You are Pre-Obese...";
                Results.textColor = UIColor.purple;
            }
            else if(calc >= 30)
            {
                Results.text = "You are Obese...";
                Results.textColor = UIColor.red;
            }
        }
    }
}
