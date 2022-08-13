//
//  ViewController.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/09.
//

import UIKit

class ViewController: UIViewController {

    let a: () -> Void = { }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var b = a
        print(b)
        self.view.backgroundColor = .red
    }


}

