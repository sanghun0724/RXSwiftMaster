//
//  ViewController.swift
//  IGif
//
//  Created by sangheon on 2021/10/24.
//

import UIKit
import RxSwift
import SwiftyJSON

class MainTableViewController: UITableViewController {
   
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
                return ApiController.shared.search(text: query)
                    .catchAndReturn([])
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.gifs = result
                self.tableView.reloadData()
            })
            .disposed(by:bag)
    }
    
    //MARK: - Table View Data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GifCell",for: indexPath) as? GifTableViewCell else {
            return UITableViewCell()
        }
        
        let gif = gifs[indexPath.row]
        if let url = gif["images"]["fixed_height_small"]["url"].string {
            print(url)
            cell.downloadAndDisplay(gif:url)
        }
        
        return cell
    }
}

extension MainTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        search.onNext(searchController.searchBar.text ?? "")
    }
}
