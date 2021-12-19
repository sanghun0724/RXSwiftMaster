//
//  ArticleCell.swift
//  RxSwiftPractice
//
//  Created by sangheon on 2021/12/19.
//

import UIKit
import RxSwift
import SDWebImage

class ARticleCell:UICollectionViewCell {
    //MARK:Properties
    var viewModel = PublishSubject<ArticleViewModel>()
    private let disposeBag = DisposeBag()
    
    lazy var imageView:UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 60).isActive = true
        iv.backgroundColor = .secondarySystemBackground
        return iv
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    //MARK: Helpers
    func subscribe() {
        self.viewModel.subscribe(onNext: { ArticleViewModel in
            if let urlString = ArticleViewModel.imageUrl {
                self.imageView.sd_setImage(with: URL(string: urlString), completed: nil)
            }
            self.titleLabel.text = ArticleViewModel.title
            self.descriptionLabel.text = ArticleViewModel.description
        }).disposed(by: disposeBag)
    }
    
    //MARK: Configures
    func configureUI() {
        backgroundColor = .systemBackground
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor,constant: 20).isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor,constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor,constant: -40).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
    }
    
}
