//
//  GifTableViewCell.swift
//  IGif
//
//  Created by sangheon on 2021/10/24.
//

import UIKit
import RxSwift
import Gifu

class GifTableViewCell:UITableViewCell {
    @IBOutlet weak var gifImageView:UIImageView!
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    
    var disposable = SingleAssignmentDisposable()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gifImageView.image = nil
        disposable.dispose()
    }
    
    func downloadAndDisplay(gif stringurl:String) {
        guard let url = URL(string: stringurl) else { return }
        let request = URLRequest(url: url)
        activityIndicator.startAnimating()
    }
}

extension UIImageView:GIFAnimatable {
    public var animator: Animator? {
        get {
            <#code#>
        }
        set(newValue) {
            <#code#>
        }
    }
    
    
}
