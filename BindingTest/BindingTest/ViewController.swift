//
//  ViewController.swift
//  BindingTest
//
//  Created by sangheon on 2022/02/05.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private let button:UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        return button
    }()
    
    private let vm = ViewModel()
    private let db = DisposeBag()
    
    private let tableView:UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        binding()
        view.addSubview(button)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        button.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100)
    }
    
    
    
    func binding() {
        vm.load()
        
        vm.dogs
        .subscribe(onNext: { dog in
            self.tableView.reloadData()
            print(self.vm.dogs.value.count)
        })
        .disposed(by: db)
        
        button.rx.tap
            .bind { _ in
                self.vm.load()
            }.disposed(by: db)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.dogs.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = vm.dogs.value[indexPath.row].name
        return cell
    }
}

