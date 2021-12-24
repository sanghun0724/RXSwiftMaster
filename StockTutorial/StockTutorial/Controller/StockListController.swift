//
//  StockListController.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/22.
//

import UIKit
import Pure
import RxSwift
import RxCocoa

class StockListController:BaseViewController,FactoryModule {
    
    struct Dependency { //주입받을 의존성들의 타입을 여기서 지정
        let viewModel: StockListViewModel
    }
    
    let selfView = StockListView()
    let viewModel:StockListViewModel
    
    required init(dependency: Dependency, payload: ()) {
        viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureUI() {
        view.addSubview(self.selfView)
        selfView.translatesAutoresizingMaskIntoConstraints = false
        selfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        selfView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        selfView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        selfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        
        
        selfView.searchViewController.delegate = self
        selfView.searchViewController.searchResultsUpdater = self
        
        navigationItem.searchController = selfView.searchViewController
    }
    
    func bind() {
        
        selfView.searchViewController.searchBar.rx.text
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { text in
                guard let text = text, !text.isEmpty else { return }
                self.viewModel.searchQueryChanged(query: text)
            }).disposed(by: disposeBag)
        
        viewModel.$errorMessage.sink { errorMessage in
            guard let message = errorMessage, !message.isEmpty else { return }
            print("error: \(message)")
        }.store(in: &subscriber)
        
        viewModel.$stocks.sink { [unowned self]stocks in
            self.selfView.tableView.reloadData()
            print("stocks:\(stocks)")
        }.store(in: &subscriber)
        
        viewModel.$loading.sink { loading in
            self.selfView.loadingView.isHidden = !loading
        }.store(in: &subscriber)
}
    
}

extension StockListController:UISearchControllerDelegate {
}

extension StockListController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
