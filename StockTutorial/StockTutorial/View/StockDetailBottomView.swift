//
//  StockDetailBottomView.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/26.
//

import UIKit

class StockDetailBottomView:BaseView {
    
    
    class InputView:BaseView {
        let textField = UITextField()
        let descriptionLabel = SmallLabel()
        let valueLabel = NormalGrayLabel()
        
        override func configureUI() {
            textField.font = UIFont.systemFont(ofSize: 18)
            textField.autocorrectionType = .no
            addSubview(textField)
            addSubview(descriptionLabel)
            addSubview(valueLabel)
            textField.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            valueLabel.translatesAutoresizingMaskIntoConstraints = false
            
            textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
            textField.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            textField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            
            descriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 8).isActive = true
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            valueLabel.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor).isActive = true
            valueLabel.rightAnchor.constraint(equalTo: descriptionLabel.rightAnchor, constant: 4).isActive = true
            
        }
        
    }
}
