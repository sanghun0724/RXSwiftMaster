//
//  Dogs.swift
//  BindingTest
//
//  Created by sangheon on 2022/02/05.
//

import Foundation

struct Weight :Equatable, Codable {
    var imperial:String
    var metric:String
}

struct Height : Equatable, Codable {
    var imperial:String
    var metric:String
}

struct Image :Equatable,Codable {
    var id:String
    var width:Int
    var height:Int
    var url:String
}

struct Dog :Equatable,Codable {
    var weight:Weight
    var height:Height
    var id:Int
    var name:String
    var breed_group:String?
    var life_span:String
    var temperament:String?
    var reference_image_id:String
    var image:Image
}
