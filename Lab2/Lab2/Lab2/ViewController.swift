//
//  ViewController.swift
//  Lab2
//
//  Created by Richard Marquez on 2/6/22.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var earthWeight: UITextField!
    @IBOutlet weak var returnLabel: UILabel!
    var message:String?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for seque: UIStoryboardSegue, sender: Any?)
    {
        if(seque.identifier == "earthToMoon")
        {
            let des = seque.destination as! SecondViewController
            des.message = "Coming from the Earth"
            des.data = earthWeight.text
        }
    }
    
    @IBAction func returning1(seque: UIStoryboardSegue)
    {
        if let sourceViewController = seque.source as? SecondViewController
        {
            returnLabel.text = "Coming from the Moon"
            returnLabel.isHidden = false
        }
        else if let sourceViewController = seque.source as? ThirdViewController
        {
            returnLabel.text = "Coming from Jupiter"
            returnLabel.isHidden = false
        }
    }
}
