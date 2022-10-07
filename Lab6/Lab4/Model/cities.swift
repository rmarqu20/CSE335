//
//  cities.swift
//  Lab4
//
//  Created by Richard Marquez on 2/27/22.
//

import Foundation

class cities
{
    var cities:[city] = []
    
    init()
    {
        let c1 = city(cn:"Phoenix, Arizona", cd:"Phoenix is the capital of the southwestern U.S. State of Arizona.", cin:"Phoenix.jpeg")
        let c2 = city(cn:"Tempe, Arizona", cd:"Tempe is a city just east of Phoenix, in Arizona.", cin:"Tempe.jpeg")
        let c3 = city(cn:"Goodyear, Arizona", cd:"Goodyear is a city in Maricopa County, Arizona, United States.", cin:"Goodyear.jpeg")
        let c4 = city(cn:"Flagstaff, Arizona", cd:"Flagstaff is a city in the U.S. state of Arizona, surrounded by mountains, desert and ponderosa pine forests.", cin:"Flagstaff.jpeg")
        let c5 = city(cn:"Tuscon, Arizona", cd:"Tucson is a city in Arizona, United States, and is home to the University of Arizona.", cin:"Tuscon.jpeg")
        
        cities.append(c1)
        cities.append(c2)
        cities.append(c3)
        cities.append(c4)
        cities.append(c5)
    }
    
    func getCount() -> Int
    {
        return cities.count
    }
    
    func getCity(item:Int) -> city
    {
        return cities[item]
    }
    
    func removeCity(item:Int)
    {
        cities.remove(at: item)
    }
    
    func addCity(name:String, desc:String, image:String) -> city
    {
        let city = city(cn:name, cd:desc, cin:image)
        cities.append(city)
        return city
    }
}

class city
{
    var cityName:String?
    var cityDescription:String?
    var cityImageName:String?
    
    init(cn:String, cd:String, cin:String)
    {
        self.cityName = cn
        self.cityDescription = cd
        self.cityImageName = cin
    }
}
