//
//  ViewController.swift
//  Lab4
//
//  Created by Richard Marquez on 2/27/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var cityList:cities = cities();
    @IBOutlet weak var cityTable: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cityList.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
                cell.layer.borderWidth = 1.0
                
        // calling the model to get the city object each row
        let cityItem = cityList.getCity(item:indexPath.row)
                
        cell.cityNameLabel.text = cityItem.cityName;
        cell.cityImage.image = UIImage(named: cityItem.cityImageName!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle
    {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        // delete the data from the city table,  Do this first, then use method 1 or method 2
        cityList.removeCity(item: indexPath.row)
        
        //Method 1
        //self.cityTable.beginUpdates()
        //self.cityTable.deleteRows(at: [indexPath], with: .automatic)
        //self.cityTable.endUpdates()
        
        //Method 2
        self.cityTable.reloadData()
    }
    
    @IBAction func refresh(_ sender: AnyObject)
    {
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the City Here"
        })
           alert.addTextField(configurationHandler: { textField in
               textField.placeholder = "Enter Description of the City Here"
           })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            // Do this first, then use method 1 or method 2
            if let name = alert.textFields?.first?.text
            {
                print("city name: \(name)")
                
                if let descript = alert.textFields?.last?.text
                {
                    print("city description: \(descript)")
                
                self.cityList.addCity(name: name, desc: descript, image: "image.png")
                
                //Method 2
                self.cityTable.reloadData()
            }
            }}))
        
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        
        let city = cityList.getCity(item: selectedIndex.row)
        
        if(segue.identifier == "detailView")
        {
            if let viewController: SecondViewController = segue.destination as? SecondViewController
            {
                viewController.selectedCity = city.cityName
                viewController.selectedCityDescription = city.cityDescription
                viewController.selectedCityImage = city.cityImageName
            }
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
