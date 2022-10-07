//
//  RiskController.swift
//  Homework1
//
//  Created by Richard Marquez on 4/9/22.
//

import UIKit

class RiskController: UIViewController
{
    @IBOutlet weak var goodHealthLabel: UILabel!
    @IBOutlet weak var weightRiskLabel: UILabel!
    @IBOutlet weak var sugarRiskLabel: UILabel!
    @IBOutlet weak var bloodRiskLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        goodHealthLabel.isHidden = true
        image.image = UIImage(named: "SadFace.png")
        //0 healthy 1 unhealthy 2 not enough data
        let wRisk = Health.shared.checkWeight()
        if(wRisk == 1)
        {
            weightRiskLabel.text = "You are gaining weight!"
        }
        else if(wRisk == 0)
        {
            weightRiskLabel.text = "You are NOT gaining weight!"
        }
        else
        {
            weightRiskLabel.text = "Not Enough Data! All seven days of the week needed."
        }
        let sRisk = Health.shared.checkSugar()
        if(sRisk == 1)
        {
            sugarRiskLabel.text = "Your sugar level is high!"
        }
        else if(sRisk == 0)
        {
            sugarRiskLabel.text = "Your sugar level is normal!"
        }
        else
        {
            sugarRiskLabel.text = "Not Enough Data! Two days worth of data minimum."
        }
        //checks systolic pressure
        let bRisk = Health.shared.checkBlood()
        if(bRisk == 1)
        {
            bloodRiskLabel.text = "Your blood pressure is high!"
        }
        else if(bRisk == 0)
        {
            bloodRiskLabel.text = "Your blood pressure is normal!"
        }
        else
        {
            bloodRiskLabel.text = "Not Enough Data! Two days worth of data minimum."
        }
        
        if((wRisk != 1) && (sRisk != 1) && (bRisk != 1))
        {
            goodHealthLabel.isHidden = false
            image.image = UIImage(named: "SmileyFace.png")
        }
    }
}
