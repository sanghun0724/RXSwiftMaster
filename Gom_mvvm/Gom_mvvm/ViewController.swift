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
        viewModel.moveDay(day: -1)
    }
    
    @IBAction func onNow(_ sender: Any) {
        dateTimeLabel.text = "Loding.."
        viewModel.reload()
    }
    
    @IBAction func onTomorrow(_ sender: Any) {
        viewModel.moveDay(day: 1)
    }
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.onUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.dateTimeLabel.text = self?.viewModel.dateTimeString
            }
        }
        
        viewModel.reload()
    }


}

