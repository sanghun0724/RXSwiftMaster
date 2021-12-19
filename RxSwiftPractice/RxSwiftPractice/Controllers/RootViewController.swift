//
//  RootViewController.swift
//  RxSwiftPractice
//
//  Created by sangheon on 2021/12/19.
//

import UIKit
import RxSwift
import RxRelay

class RootViewController:UIViewController {
    
    //MARK: Properties
    let viewModel:RootViewModel
    private let disposeBag = DisposeBag()
    
    private let articles  = BehaviorRelay<[Article]>(value:[])
    var articlesObserver:Observable<[Article]> {
        return articles.asObservable()
    }
    
    //MARK: LifeCycles
    init(viewModel:RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchArticles()
    }
    
    func configureUI() {
        view.backgroundColor = .red
    }
    
    //MARK:Configures
    func fetchArticles() {
        self.viewModel.fetchArticles().subscribe(onNext: { articles in
            self.articles.accept(articles)
        }).disposed(by: disposeBag)
    }
    
    func subscribe() {
        self.articlesObserver.subscribe(onNext:  { articles in
            //collectionView.reload here
        }).disposed(by: disposeBag)
    }
    
}
