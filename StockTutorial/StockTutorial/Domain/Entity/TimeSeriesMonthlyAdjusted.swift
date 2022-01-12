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
    var monthInfos:[MonthInfo] = [] //codable 아니기 때문에 초기값 필수
    
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
    
   mutating func generateMonthInfos() { //monthInfo를 추가하기 위해 mutating keyword 추가
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
    self.monthInfos = monthInfos
    }
    
    private func generateAdjustedOpen(ohlc:OHLC) -> Double? {
        var adjustedOpen:Double?
        
        if let open = Double(ohlc.open), let close = Double(ohlc.close), let adjustedClose = Double(ohlc.adjustedClose) {
            adjustedOpen = open * (adjustedClose / close)
        }
        
        return adjustedOpen
    }
    
}
