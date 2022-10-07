//
//  movieRecord.swift
//  Lab3
//
//  Created by Richard Marquez on 2/14/22.
//

import Foundation
class movieRecord
{
    var title:String? = nil
    var genre:String? = nil
    var sale:Int32? = nil
    
    init(t:String, g:String, s:Int32)
    {
        self.title = t
        self.genre = g
        self.sale = s
    }
    
    func change_sale(newSale:Int32)
    {
        self.sale = newSale;
    }
    
}
