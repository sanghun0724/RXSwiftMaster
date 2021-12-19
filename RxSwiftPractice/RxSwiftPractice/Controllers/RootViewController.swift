//
//  RootViewController.swift
//  RxSwiftPractice
//
//  Created by sangheon on 2021/12/19.
//

import UIKit

class RootViewController:UIViewController {
    
    //MARK: Properties
    
    //MARK: LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .red
    }
    
}
