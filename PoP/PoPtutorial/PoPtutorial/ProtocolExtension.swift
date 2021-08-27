//
//  ProtocolExtension.swift
//  PoPtutorial
//
//  Created by sangheon on 2021/08/27.
//

import UIKit


//MARK: ContentContents

protocol ContainContents {
    var contents: [Content] { get }
    var numberOfContents:Int { get }
}

extension ContainContents {
    var contents:[Content] {
        return TimelineContentObject.shared.content
    }
    var numberOfContents:Int {
        return contents.count
    }
}
