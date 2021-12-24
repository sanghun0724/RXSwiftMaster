//
//  Model.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/23.
//

import Foundation

struct StockResult: Decodable {
    var items:[Stock]
    
    enum CodingKeys:String,CodingKey {
        case items = "bestMatches"
    }
}

struct Stock:Decodable {
    var symbol:String?
    var name:String?
    var type:String?
    var currency:String?
    
    enum CodingKeys:String,CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case currency = "8. currency"
    }
}
