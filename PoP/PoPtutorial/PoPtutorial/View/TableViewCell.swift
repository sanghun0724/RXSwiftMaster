//
//  TableViewController.swift
//  PoPtutorial
//
//  Created by sangheon on 2021/08/15.
//

import UIKit

class TableViewCell:UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Helper
    func configureView() {
        backgroundColor = .systemBackground
        
        
    }
    
}
