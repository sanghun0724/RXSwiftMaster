//
//  ApiController.swift
//  RxWeatherApp
//
//  Created by sangheon on 2021/09/26.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class ApiController {
    
    struct Weather {
        let cityName: String
        let temperature:Int
        let humidity:Int
        let icon:String
        
        static let empty = Weather(cityName: "UnKnown",
                                   temperature: -1000,
                                   humidity: 0,
                                   icon: iconNameToChar(icon: "e"))
    }
    
    /// the shared instance
    static var shared = ApiController()
    
    private let apiKey = "my key"
    
    let baseURL = URL(string: "")
    
    init() {
        
    }
    
    func currentWeather(city:String) -> Observable<Weather> {
        return Observable.just(Weather(cityName: city, temperature: 20, humidity: 90, icon: iconNameToChar(icon: "01d")))
    }
    
    //MARK: Private Methods
    //buildRequest with RxCocoa
    private func buildRequest(method:String = "GET", pathComponent:String,params:[(String,String)]) -> Observable<JSON> {
        
        guard let url = baseURL?.appendingPathComponent(pathComponent) else {
            return Observable<JSON>.empty()
        }
        var request = URLRequest(url: url)
        let keyQueryItem = URLQueryItem(name: "appid", value: apiKey)
        let unitsQueryItem = URLQueryItem(name: "units", value: "metric")
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if method == "GET" {
            var queryItems = params.map {
                URLQueryItem(name: $0.0, value: $0.1)
            }
            queryItems.append(keyQueryItem)
            queryItems.append(unitsQueryItem)
            urlComponents.queryItems = queryItems
        } else { //POST
            urlComponents.queryItems = [keyQueryItem,unitsQueryItem]
            
            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
    
    
    
    public func iconNameToChar(icon: String) -> String {
      switch icon {
      case "01d":
        return "\u{f11b}"
      case "01n":
        return "\u{f110}"
      case "02d":
        return "\u{f112}"
      case "02n":
        return "\u{f104}"
      case "03d", "03n":
        return "\u{f111}"
      case "04d", "04n":
        return "\u{f111}"
      case "09d", "09n":
        return "\u{f116}"
      case "10d", "10n":
        return "\u{f113}"
      case "11d", "11n":
        return "\u{f10d}"
      case "13d", "13n":
        return "\u{f119}"
      case "50d", "50n":
        return "\u{f10e}"
      default:
        return "E"
      }
}
    

