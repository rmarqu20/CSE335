//
//  SecondViewController.swift
//  Lab2
//
//  Created by Richard Marquez on 2/6/22.
//

import UIKit

class SecondViewController: UIViewController
{
    var data:String?
    var message:String?
    var moonWeight:Int?
    
    @IBOutlet weak var earthLabel: UILabel!
    @IBOutlet weak var moonLabel: UILabel!
    @IBOutlet weak var returnLabel: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        moonWeight = Int(data!)
        moonWeight = moonWeight!/6
        earthLabel.text = data
        moonLabel.text = String(moonWeight!)
        returnLabel.text = message
        returnLabel.isHidden = false
    }

    override func prepare(for seque: UIStoryboardSegue, sender: Any?)
    {
        if(seque.identifier == "moonToJupiter")
        {
            let des = seque.destination as! ThirdViewController
            des.message = "Coming from the Moon"
            des.data = String(data!)
            des.moonWeight = String(moonWeight!)
        }
    }
    
    @IBAction func returning2(seque: UIStoryboardSegue)
    {
        if let sourceViewController = seque.source as? ViewController
        {
            returnLabel.text = "Coming from the Earth"
            returnLabel.isHidden = false
        }
        else if let sourceViewController = seque.source as? ThirdViewController
        {
            returnLabel.text = "Coming from Jupiter"
            returnLabel.isHidden = false
        }
    }
}
