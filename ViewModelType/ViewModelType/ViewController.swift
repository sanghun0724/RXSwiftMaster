//
//  ViewController.swift
//  ViewModelType
//
//  Created by sangheon on 2022/07/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countBtn: UIButton!
    
    let viewModel = ViewModel(dependency: .init(dummy: 0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    private func setUpBindings() {
        
    }
}

