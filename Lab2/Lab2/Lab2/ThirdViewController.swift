//
//  ThirdViewController.swift
//  Lab2
//
//  Created by Richard Marquez on 2/6/22.
//

import UIKit

class ThirdViewController: UIViewController
{
    var data:String?
    var message:String?
    var moonWeight:String?
    var jupiterWeight:Double?
    
    @IBOutlet weak var earthLabel: UILabel!
    @IBOutlet weak var moonLabel: UILabel!
    @IBOutlet weak var jupiterLabel: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        earthLabel.text = data
        moonLabel.text = moonWeight
        jupiterWeight = Double(data!)
        jupiterWeight = jupiterWeight! * 2.5
        jupiterLabel.text = String(jupiterWeight!)
    }

    override func prepare(for seque: UIStoryboardSegue, sender: Any?)
    {
        if(seque.identifier == "jupiterToMoon")
        {
            let des = seque.destination as! SecondViewController
            des.message = "Coming from Jupiter"
        }
        if(seque.identifier == "jupiterToEarth")
        {
            let des = seque.destination as! ViewController
            des.message = "Coming from Jupiter"
        }
    }
}
