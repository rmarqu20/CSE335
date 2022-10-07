//
//  cities.swift
//  Lab4
//
//  Created by Richard Marquez on 2/27/22.
//

import Foundation
import CoreData
import UIKit

class cities
{
    var counter = 0
    
    //this is the array to store City entities from the coredata
    var fetchResults = [City]()
    
    // handler to the managege object context
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init()
    {
        
    }
    //create a new city
    func addNewCity(cName: String?, cDescription: String?, cImage: NSData)
    {
        // create a new entity object
        let ent = NSEntityDescription.entity(forEntityName: "City", in: self.managedObjectContext)
        //add to the manage object context
        let newItem = City(entity: ent!, insertInto: self.managedObjectContext)
        //assign city data
        newItem.cityName = cName
        newItem.cityDescription = cDescription
        newItem.cityImage = cImage
    }
    //fetch city count from core data
    func fetchRecord() -> Int
    {
        // Create a new fetch request using the CityEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        let sort = NSSortDescriptor(key: "cityName", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        var x = 0
        // Execute the fetch request, and cast the results to an array of City objects
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [City])!
        //print core data count
        x = fetchResults.count
        print(x)
        // return how many entities in the coreData
        return x
    }
    //fetch core data
    func fetch()
    {
        let request: NSFetchRequest<City> = City.fetchRequest()
        do
        {
            self.fetchResults = try managedObjectContext.fetch(request)
        }
        catch
        {
            print("Error: \(error.localizedDescription)")
        }
    }
    //starts counter
    func initCounter()
    {
        counter = UserDefaults.init().integer(forKey: "counter")
    }
    //updates counter when new city is added
    func updateCounter()
    {
        counter += 1
        UserDefaults.init().set(counter, forKey: "counter")
        UserDefaults.init().synchronize()
    }
}
//city constructor 
class city
{
    var cityName:String?
    var cityDescription:String?
    var cityImageName:NSData?
    
    init(cn:String, cd:String, cin:NSData)
    {
        self.cityName = cn
        self.cityDescription = cd
        self.cityImageName = cin
    }
}

