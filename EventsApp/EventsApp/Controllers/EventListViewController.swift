//
//  EventListViewController.swift
//  EventsApp
//
//  Created by sangheon on 2022/02/02.
//

import UIKit
import CoreData

class EventListViewController: UIViewController {
    
    var viewModel:EventListViewModel!
    
    private let coreDataManager = CoreDataManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setNavigationItem()
        
       
    }
    
    private func setNavigationItem() {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(didTapRightButton))
        barButtonItem.tintColor =  .primary
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc private func didTapRightButton() {
        viewModel.didTapRightButton()
    }
}
