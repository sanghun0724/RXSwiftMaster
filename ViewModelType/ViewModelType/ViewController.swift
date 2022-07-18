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
    let viewModel = ViewModel(dependency: .init(dummy: 0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
    }
    
    private func setUpBindings() {
        let input = ViewModel.Input(didTapBtn: countBtn.rx.tap.asObservable() )
        let output = viewModel.transform(input: input)
        
        output.countNum
            .map { String($0) }
            .drive(countLabel.rx.text)
            .disposed(by: disposeBag)
        //drive vs bind
        //drive = main thread + 그때문에 stream 낭비 x
    }
}

