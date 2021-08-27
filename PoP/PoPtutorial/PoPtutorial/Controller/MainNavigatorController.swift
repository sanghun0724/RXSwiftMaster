//
//  ViewController.swift
//  PoPtutorial
//
//  Created by sangheon on 2021/08/15.
//

import UIKit
//굳이 Stirng RawValue를 지정한이유 ?
// Implicitly Assigned Raw Values Table = "Table" , Collection = "Collection"
//Sometimes you need to be able to assign values to enums so they have meaning. This lets you create them dynamically, and also use them in different ways

enum ListViewMode:String {
    case Table, Collection
}

class MainNavigatorController:UINavigationController {
    private var tableViewController:UITableViewController?
    private var collectionViewController:UICollectionViewController?
    
    private var listViewMode: ListViewMode  = .Table {
        didSet {
             viewModeChanged()
        }
    }
    override func viewDidLoad() {
        print("check")
        viewModeChanged()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //storyBoard나 xib로 뷰를 만들경우 init대신 요거 호출 
//        instance가 만들어진 후에 호출 (IBOutlet, IBAction 스토리보드의 View가 모두 바인딩 됨)
//        awakeFromNib가 호출되는 시점에는 IBAction과 IBOutlet이 연결되어 있으므로 이들은 nil이 아님을 보장한다.
//
//        nib을 사용하는 경우 불려지는 순서
//        init -> initWithCoder -> awakeFromNib
//
//        nib를 사용하지않는 경우 불려지는 순서
//        init -> initWithFrame
//        nib 파일 내 오브젝트들은 initWithFrame이 호출되지 않는다.

    }

    // MARK: State Restoration
    private func viewModeChanged() {
        var rootViewController:UIViewController?
        
        switch listViewMode {
        case .Table:
            if let tableController = tableViewController { //TableView 상태에서 tableview 전환했을떄 (중복일떄)
                rootViewController = tableController
            } else {
                tableViewController = TimelineTableViewController()
            }
            rootViewController = tableViewController
            
        case .Collection:
            if let collectionController = collectionViewController {
                rootViewController = collectionController
            } else {
                print("Empty")
            }
            rootViewController = collectionViewController
        }
            guard let root = rootViewController else {
                return
            }
            let chageViewModeButton:UIBarButtonItem = UIBarButtonItem(title: "Mode", style: UIBarButtonItem.Style.plain, target: self, action: #selector(pivotViewMode))
            
            root.navigationItem.leftBarButtonItem = chageViewModeButton
            
            viewControllers = [root] //current viewController stack
    }

    @objc private func pivotViewMode() {
        if listViewMode == .Table {
            listViewMode = .Collection
        } else { //if .collection
            listViewMode = .Table
        }
    }
    
    
}

