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
    
    private lazy var collectionView:UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        cv.delegate = self
        cv.dataSource = self
        
        cv.backgroundColor = .systemBackground
        
        return cv
    }()
    
    let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleViewModelObserver:Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
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
        configureCollectionView()
        fetchArticles()
        subscribe()
    }
    
    //MARK:Configures
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        self.title = self.viewModel.title
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureCollectionView() {
        self.collectionView.register(ARticleCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    //MARK: Helper
    func fetchArticles() {
        viewModel.fetchArticles().subscribe(onNext: { articleViewModel in
            self.articleViewModel.accept(articleViewModel)
        }).disposed(by: disposeBag)
    }
    
    func subscribe() {
        self.articleViewModelObserver.subscribe(onNext: { articles in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
}
