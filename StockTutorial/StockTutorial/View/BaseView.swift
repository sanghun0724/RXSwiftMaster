//
//  BaseView.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/22.
//

import UIKit

class BaseView:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.backgroundColor = .systemBackground
    }
}
