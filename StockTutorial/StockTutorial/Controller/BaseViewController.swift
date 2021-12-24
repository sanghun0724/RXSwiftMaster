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
    private var scrollView:UIScrollView?
    
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
    
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let scrollView = scrollView else { return }
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }
}
