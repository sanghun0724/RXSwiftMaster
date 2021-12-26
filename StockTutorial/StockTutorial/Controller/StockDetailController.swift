//
//  StockDetailController.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/25.
//

import UIKit
import Pure

class StockDetailController:BaseViewController , FactoryModule {
    struct Dependency {
        let stock:Stock
    }
    
    let stock:Stock
    let selfView = StockDetailView()

    required init(dependency:Dependency,payload:()) {
        stock = dependency.stock
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        view.backgroundColor = .systemBackground
        title = "DetailView"
        view.addSubview(selfView)
        selfView.translatesAutoresizingMaskIntoConstraints = false
        selfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        selfView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        selfView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        selfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
