//
//  ViewController.swift
//  ViewModelType
//
//  Created by sangheon on 2022/07/17.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countBtn: UIButton!
    
    let disposeBag = DisposeBag()
    let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = ViewModel(dependency: .init(dummy: 0))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
        // Do any additional setup after loading the view.
    }
    
    
    private func setUpBindings() {
         let input = ViewModel.Input(didTapBtn: countBtn.rx.tap.asObservable() )
         let output = viewModel.transform(input: input)
        
        output.countNum
            .map { String($0) }
            .drive(countLabel.rx.text)
            .disposed(by: disposeBag)
        
  
        
    }
}

