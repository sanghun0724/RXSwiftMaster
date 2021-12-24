//
//  BaseViewController.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/22.
//

import UIKit
import RxSwift
import Combine

class BaseViewController:UIViewController {
    
    let disposeBag = DisposeBag()
    var subscriber: Set<AnyCancellable> = .init()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
}
