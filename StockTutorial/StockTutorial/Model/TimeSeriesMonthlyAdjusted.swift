//
//  TimeSeriesMonthlyAdjusted.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/27.
//

import Foundation

struct TimeSeriesMonthlyAdjusted: Decodable {
    let meta: Meta
    let series:[String:OHLC]
    
    enum CodingKeys:String, CodingKey {
        case meta = "Meta Data"
        case series = "Monthly Adjusted Time Series"
    }
    
    struct OHLC:Decodable {
        let open:String
        let close:String
        let adjustedClose:String
        
        enum CodingKeys:String,CodingKey {
            case open = "1. open"
            case close = "4. close"
            case adjustedClose = "5. adjusted close"
        }
    }
    
    struct Meta: Decodable {
        let symbol:String
        
        enum CodingKeys:String,CodingKey {
            case symbol = "2. Symbol"
        }
    }
    
    func generateMonthInfos() -> [MonthInfo] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var monthInfos:[MonthInfo] = []
        
        let sortedSeries = series.sorted { $0.key > $1.key }
        
        sortedSeries.forEach { (dateString,ohlc) in
            if let date = dateFormatter.date(from: dateString) , let adjustedClose = Double(ohlc.adjustedClose),let adjustOpen = generateAdjustedOpen(ohlc: ohlc){
            let monthInfo:MonthInfo = .init(date: date, adjustedOpen:adjustOpen , adjustedClosed: adjustedClose)
                monthInfos.append(monthInfo)
            }
        }
        return monthInfos
    }
    
    private func generateAdjustedOpen(ohlc:OHLC) -> Double? {
        var adjustedOpen:Double?
        
        if let open = Double(ohlc.open), let close = Double(ohlc.close), let adjustedClose = Double(ohlc.adjustedClose) {
            adjustedOpen = open * (adjustedClose / close)
        }
        
        return adjustedOpen
    }
    
}
