//
//  ViewController.swift
//  IGif
//
//  Created by sangheon on 2021/10/24.
//

import UIKit
import RxSwift
import SwiftyJSON

class MainTableViewController: UITableViewController, UISearchResultsUpdating {
   
    
    
    let searchController = UISearchController(searchResultsController: nil)
    let bag = DisposeBag()
    var gifs = [JSON]()
    let search = BehaviorSubject(value: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iGif"
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        search.filter { $0.count >= 3}
            .throttle(RxTimeInterval.milliseconds(3), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest{ query -> Observable<[JSON]> in
                return 
            }
        
    }

    func updateSearchResults(for searchController: UISearchController) {
      
    }

}

