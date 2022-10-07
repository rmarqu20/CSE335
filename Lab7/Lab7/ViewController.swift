//
//  ViewController.swift
//  Lab7
//
//  Created by Richard Marquez on 3/29/22.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var earthquakeInfoLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    struct earthquakeResults: Decodable
    {
        let datetime: String
        let depth: Double
        let long: Double
        let src: String
        let equid: String
        let magnitude: Double
        let lat: Double
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ShowInformation(_ sender: UIButton)
    {
        self.earthquakeInfoLabel.text = ""
        let geoCoder = CLGeocoder();
        let addressString = address.text!
        var lat = 0.0
        var long = 0.0
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
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
                        lat = coords.latitude
                        long = coords.longitude
                        //print(location)
                        print("Lat: \(lat)")
                        print("Long: \(long)")
                        
                        self.latitudeLabel.isHidden = false
                        self.latitudeLabel.text = "\(lat)"
                        self.longitudeLabel.isHidden = false
                        self.longitudeLabel.text = "\(long)"
                        
                        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                        let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                        self.map.setRegion(region, animated: true)
                        let ani = MKPointAnnotation()
                        ani.coordinate = placemark.location!.coordinate
                        ani.title = placemark.locality
                        ani.subtitle = placemark.subLocality
                        
                        self.map.addAnnotation(ani)
                        
                        //earthquake service
                        let north = lat + 10.0
                        let south = lat - 10.0
                        let east = long - 10.0
                        let west = long + 10.0
                        
                        let urlAsString = "http://api.geonames.org/earthquakesJSON?north=\(north)&south=\(south)&east=\(east)&west=\(west)&username=rmarqu20"
                        print("URL: " + urlAsString)
                        let url = URL(string: urlAsString)!
                        let urlSession = URLSession.shared
                        
                        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                            if(error != nil)
                            {
                                print(error!.localizedDescription)
                            }
                            var err: NSError?
                            
                            var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                            if(err != nil)
                            {
                                print("JSON Error \(err!.localizedDescription)")
                            }
                            
                            print(jsonResult)
                            
                            let setOne:NSArray = jsonResult["earthquakes"] as! NSArray
                            for i in setOne
                            {
                                let y = i as? [String: AnyObject]
                                print(y?["eqid"])
                                let date: String = (y!["datetime"] as? NSString)! as String
                                let mag: Double = (y!["magnitude"] as? NSNumber)!.doubleValue
                                print(date)
                                print(mag)
                                
                                DispatchQueue.main.async
                                {
                                    self.earthquakeInfoLabel.text = (self.earthquakeInfoLabel.text ?? "") + "Date: " + date + " Mag: \(mag)\n"
                                }
                            }
                        })
                        jsonQuery.resume()         
                    }
                })
    }
}
