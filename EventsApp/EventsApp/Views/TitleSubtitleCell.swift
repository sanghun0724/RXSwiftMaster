//
//  TitleSubtitleCell.swift
//  EventsApp
//
//  Created by sangheon on 2022/02/02.
//

import UIKit
import SnapKit

final class TitleSubtitleCell:UITableViewCell {
    static let identifier = "TitleSubtitleCell"
    
    private let titleLable = UILabel()
    private let subtitleTextField = UITextField()
    private let verticalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setUpHierarchy()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: TitleSubTitleCellViewModel) {
        titleLable.text = viewModel.title
        subtitleTextField.text = viewModel.subtitle
        subtitleTextField.placeholder = viewModel.placeholder
    }
    
    private func setUpViews() {
        verticalStackView.axis = .vertical
        titleLable.font = .systemFont(ofSize: 22,weight: .medium)
        subtitleTextField.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
    private func setUpHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLable)
        verticalStackView.addArrangedSubview(subtitleTextField)
    }
    
    private func setUpLayout() {
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
    }
}

