//
//  AddEventViewController.swift
//  EventsApp
//
//  Created by sangheon on 2022/02/02.
//

import UIKit
import SnapKit

class AddEventViewController: UIViewController {
    
    private let tableView:UITableView = {
        let table = UITableView()
        table.register(TitleSubtitleCell.self, forCellReuseIdentifier: TitleSubtitleCell.identifier)
        return table
    }()
    
    
    
    var viewModel:AddEventViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        viewModel.viewDidLoad()
        configureUI()
        
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.setContentOffset(.init(x: 0, y: -1), animated: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }
    
    @objc private func tappedDone() {
        viewModel.tappedDone()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
   
    
}

extension AddEventViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberofRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cell(for:indexPath)
        switch cellViewModel {
        case .titleSubtitle(let titleSubTitleCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleSubtitleCell.identifier,for:indexPath) as! TitleSubtitleCell
            
            cell.update(with: titleSubTitleCellViewModel)
            return cell
        case .titleImage:
            return UITableViewCell()
        }
    }
}




