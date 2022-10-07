//
//  infoDictionary.swift
//  Lab3
//
//  Created by Richard Marquez on 2/14/22.
//

import Foundation
class infoDictionary
{
    // dictionary that stores person records
    var infoRepository : [String:movieRecord] = [String:movieRecord] ()
    var recArray = [movieRecord]()
    
    init() { }
  
    func add(_ title:String, _ genre:String, _ sale:Int32)
    {
        let pRecord =  movieRecord(t: title, g:genre, s:sale)
        infoRepository[pRecord.title!] = pRecord
        recArray.insert(pRecord, at: recArray.endIndex)
        print("adding " + pRecord.title!)
    }
    
    func search(s:String) -> movieRecord?
    {
        var found = false
        print("searching for " + s)
        for (title, _) in infoRepository
        {
            if title == s
            {
                found = true
                break
            }
        }
        if found
        {
           return infoRepository[s]
        }
        else
        {
            return nil
        }
    }
    
    func deleteRec(s:String)
    {
        print("deleting " + s)
        infoRepository[s] = nil
        var index = 0
        for rec in recArray
        {
            if(rec.title == s)
            {
                recArray.remove(at: index)
            }
            index += 1
        }
    }
    
    func getPreviousRec(title: String) -> movieRecord?
    {
        var prev:movieRecord? = nil
        var index:Int = 0
        for rec in recArray
        {
            if(rec.title == title)
            {
                if(index - 1 >= 0)
                {
                    prev = recArray[index - 1]
                }
            }
            index += 1
        }
        return prev
    }
    
    func getNextRec(title: String) -> movieRecord?
    {
        var next:movieRecord? = nil
        var index:Int = 0
        for rec in recArray
        {
            if(rec.title == title)
            {
                if(index + 1 < recArray.endIndex)
                {
                    next = recArray[index + 1]
                }
            }
            index += 1
        }
        return next
    }
}
