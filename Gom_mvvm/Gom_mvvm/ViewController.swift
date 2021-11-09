//
//  ViewController.swift
//  Gom_mvvm
//
//  Created by sangheon on 2021/11/02.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    
    @IBAction func onYesterday(_ sender: Any) {
    }
    
    @IBAction func onNow(_ sender: Any) {
    }
    
    @IBAction func onTomorrow(_ sender: Any) {
    }
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.viewDidLoad()
        dateTimeLabel.text = viewModel.dateTimeToString
    }


}

