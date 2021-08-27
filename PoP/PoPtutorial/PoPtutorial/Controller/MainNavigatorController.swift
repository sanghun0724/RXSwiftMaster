//
//  ViewController.swift
//  PoPtutorial
//
//  Created by sangheon on 2021/08/15.
//

import UIKit
//굳이 Stirng RawValue를 지정한이유 ?
// Implicitly Assigned Raw Values Table = "Table" , Collection = "Collection"
//Sometimes you need to be able to assign values to enums so they have meaning. This lets you create them dynamically, and also use them in different ways

enum ListViewMode:String {
    case Table, Collection
}

class MainNavigator: UINavigationController {
    
    private var listViewMode: ListViewMode

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

