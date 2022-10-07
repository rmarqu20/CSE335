//
//  SecondViewController.swift
//  Lab4
//
//  Created by Richard Marquez on 2/27/22.
//

import UIKit

class SecondViewController: UIViewController, UINavigationControllerDelegate
{
    var selectedCity:String?
    var selectedCityDescription:String?
    var selectedCityImage:NSData?
    
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityNameLabel2: UILabel!
    @IBOutlet weak var cityDescriptionLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //set image and labels for selected city
        cityNameLabel2.text = selectedCity!
        cityImage.image = UIImage(data: selectedCityImage! as Data)
        cityDescriptionLabel.text = selectedCityDescription!
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
