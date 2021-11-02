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
        gifImageView.prepareForReuse()
        gifImageView.image = nil
        disposable.dispose()
        disposable = SingleAssignmentDisposable()
        //GIF다운로드를 시작했을떄, 만약 사용자가 스크롤을 내려버러기너 이미지가 렌더링 되기까지 기다리지 않는다면 다운로드를 멈추도록 해야한다.이를 위해 이 두줄 코드 작성
    }
    
    func downloadAndDisplay(gif stringurl:String) {
        guard let url = URL(string: stringurl) else { return }
        let request = URLRequest(url: url)
        activityIndicator.startAnimating()
        let s = URLSession.shared.rx.data(request: request)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { imageData in
                self.gifImageView.prepareForAnimation(withGIFData: imageData) {
                    print("it's working ")
                    print(self.gifImageView.isAnimatingGIF) // true
                }
                self.activityIndicator.stopAnimating()
            })
        disposable.setDisposable(s)
    }
}

extension UIImageView: GIFAnimatable {
  private struct AssociatedKeys {
    static var AnimatorKey = "gifu.animator.key"
  }

  override open func display(_ layer: CALayer) {
    guard let image = self.activeFrame else {
        return
    }
    layer.contentsScale = image.scale
    layer.contents = image.cgImage
    updateImageIfNeeded()
  }

  public var animator: Animator? {
    get {
      guard let animator = objc_getAssociatedObject(self, &AssociatedKeys.AnimatorKey) as? Animator else {
        let animator = Animator(withDelegate: self)
        self.animator = animator
        
        return animator
      }

      return animator
    }

    set {
      objc_setAssociatedObject(self, &AssociatedKeys.AnimatorKey, newValue as Animator?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}
