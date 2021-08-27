//
//  Contents.swift
//  PoPtutorial
//
//  Created by sangheon on 2021/08/15.
//

import Foundation

struct Content {
    enum  MediaType {
        case image,video
    }
    
    var type:Content.MediaType
    var URLString:String
    var note:String
}
