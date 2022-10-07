import UIKit

//Question 1
var age:Int?
let earthGravity:Double = 9.8
//Question 2
var RFM:Int = 35
switch RFM {
case 0...20:
    print("You are Underfat")
case 20...35:
    print("You are Healthy")
case 35...42:
    print("You are Overfat")
case _ where RFM > 42:
    print("You are Obese")
default:
    print("Invalid Number")
}
//Question 3a
let str:String = "Richard"
var reversed:String = ""
for char in str
{
    reversed.insert(char, at: reversed.startIndex)
}
print("Reversed word: " + reversed)
//Question 3b
let str2:String = "Hello reverse this string"
var result = str2.components(separatedBy: " ")
var reversed2:String = ""
for word in result
{
    for char in word
    {
        reversed2.insert(char, at: reversed2.startIndex)
    }
    reversed2.insert(" ", at: reversed2.startIndex)
}
reversed2.remove(at: reversed2.startIndex) //extra " "
print("Reserved sentence: " + reversed2)

//Question 4.1
func sumNum(arr: Array<Int>) -> (oddSum:Int, evenSum:Int)
{
    var oddSum:Int = 0
    var evenSum:Int = 0
    
    for num in arr
    {
        if(num > 0 && num % 2 == 0)
        {
            evenSum += num
        }
        else if(num > 0 && num % 2 != 0)
        {
            oddSum += num
        }
    }
    print("Odd Sum: " + String(oddSum))
    print("Even Sum: " + String(evenSum))
    return(oddSum, evenSum)
}
sumNum(arr: [0, 3, 4, -2, 6, 1, 9, -20, 10])
//Question 4.2
func shortestLongest(arr: Array<String>) -> (shortest:String, longest:String)
{
    var shortest:String = ""
    var longest:String = ""
    
    if let max = arr.max(by: {$1.count > $0.count})
    {
        longest = max as! String
    }
    if let min = arr.max(by: {$1.count < $0.count})
    {
        shortest = min as! String
    }
    print("Shortest String: " + shortest)
    print("Longest String: " + longest)
    return(shortest, longest)
}
shortestLongest(arr: ["Test", "TestTest", "TestTestTest", "TestTestTestTest"])
//Question 4.3
func searchNumber(arr: Array<Int>, num:Int) -> Bool
{
    var found:Bool = false
    for i in arr
    {
        if(i == num)
        {
            found = true
        }
    }
    print(String(num) + " found: " + String(found))
    return found
}
searchNumber(arr: [0, 1, 2, 3, 4, 5, 6], num: 3)
//Question 5
class cityStatistics
{
    var CityName:String?
    var Population:Int?
    var Longitude:Double?
    var Latitude:Double?
    
    init(city:String, pop:Int, long:Double, lat:Double)
    {
        self.CityName = city
        self.Population = pop
        self.Longitude = long
        self.Latitude = lat
    }
    func getPopulation() -> Int
    {
        return self.Population!
    }
    func getLatitude() -> Double
    {
        return self.Latitude!
    }
}



