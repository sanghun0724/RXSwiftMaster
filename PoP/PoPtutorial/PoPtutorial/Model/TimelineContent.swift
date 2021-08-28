//
//  TimelineContent.swift
//  PoPtutorial
//
//  Created by sangheon on 2021/08/15.
//

import Foundation

class TimelineContentObject {
    static let shared:TimelineContentObject = TimelineContentObject() //SingleTone
    
    var content:[Content]
    
    init() {
        var contentsArray:[Content] = [Content]()
        
        let notes:[String] = ["Michael","Mac","Tim","Crush"]
        
        for i in 0...3 {
            var content:Content?
            
            if let path:String = Bundle.main.path(forResource: "\(i)", ofType: "jpg") {
                content = Content(type: .image, URLString: path, note: notes[i])
            } else if let path:String = Bundle.main.path(forResource: "\(i)", ofType: "m4v") {
                content = Content(type: .video, URLString: path, note: notes[i])
            }
            
            if let content = content {
                contentsArray.append(content)
            }
        }
        self.content = contentsArray
        print(self.content.count)
    }
}
