//
//  Font.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/24.
//

import UIKit

class NormalGrayLabel:UILabel {
    override init(frame:CGRect) {
        super.init(frame: frame)
        textColor = .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NormalLabel:UILabel {
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class titleLabel:UILabel {
    override init(frame:CGRect) {
        super.init(frame: frame)
        font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
