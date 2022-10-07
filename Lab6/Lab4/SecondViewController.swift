//
//  SecondViewController.swift
//  Lab4
//
//  Created by Richard Marquez on 2/27/22.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, UINavigationControllerDelegate
{
    var selectedCity:String?
    var selectedCityDescription:String?
    var selectedCityImage:String?
    
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityNameLabel2: UILabel!
    @IBOutlet weak var cityDescriptionLabel: UILabel!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var mapType: UISegmentedControl!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        cityNameLabel2.text = selectedCity!
        cityImage.image = UIImage(named: selectedCityImage!)
        cityDescriptionLabel.text = selectedCityDescription!
        
        //code taken from Geo Coding lecture
        let geoCoder = CLGeocoder()
        let addressString = selectedCity
        CLGeocoder().geocodeAddressString(addressString!, completionHandler:
            {(placemarks, error) in
            if(error != nil)
            {
                print("Geocode failed: \(error!.localizedDescription)")
            }
            else if(placemarks!.count > 0)
            {
                let placemark = placemarks![0]
                let location = placemark.location
                let coords = location!.coordinate
                print(location)
                
                self.latitudeLabel.text = "\(coords.latitude)"
                self.longitudeLabel.text = "\(coords.longitude)"
                
                let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                self.map.setRegion(region, animated: true)
                let ani = MKPointAnnotation()
                ani.coordinate = placemark.location!.coordinate
                ani.title = placemark.locality
                ani.subtitle = placemark.subLocality
                
                self.map.addAnnotation(ani)
            }
        })
    }
    //uses code taken from Introduction to Maps lecture
    @IBAction func showMap(_ sender: Any)
    {
        switch(mapType.selectedSegmentIndex)
        {
        case 0:
            map.mapType = MKMapType.standard
        case 1:
            map.mapType = MKMapType.satellite
        case 2:
            map.mapType = MKMapType.hybrid
        default:
            map.mapType = MKMapType.standard
        }
    }
    //uses code taken from Introduction to Maps and Geo Coding lectures
    @IBAction func search(_ sender: UIButton)
    {
        //remove old annotations before adding new ones
        let allAnnotations = map.annotations
        map.removeAnnotations(allAnnotations)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.searchTextField.text
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response
            else
            {
                return
            }
            print(response.mapItems)
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            for i in 1...matchingItems.count - 1
            {
                let place = matchingItems[i].placemark
                //instead of printing, create annotations and add to map
                let ani2 = MKPointAnnotation()
                ani2.coordinate = place.location!.coordinate
                ani2.title = matchingItems[i].name
                ani2.subtitle = place.subLocality
                
                self.map.addAnnotation(ani2)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
