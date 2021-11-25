//
//  ViewController.swift
//  RxSwiftIn4Hours
//
//  Created by iamchiwon on 21/12/2018.
//  Copyright © 2018 n.code. All rights reserved.
//

import UIKit
import RxSwift

class AsyncViewController: UIViewController {
    // MARK: - Field

    var counter: Int = 0
    let IMAGE_URL = "https://picsum.photos/1280/720/?random"

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.counter += 1
            self.countLabel.text = "\(self.counter)"
        }
    }

    // MARK: - IBOutlet

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var countLabel: UILabel!

    // MARK: - IBAction

    @IBAction func onLoadSync(_ sender: Any) {
        let image = loadImage(from: IMAGE_URL)
        imageView.image = image
    }

    @IBAction func onLoadAsync(_ sender: Any) {
        // TODO: async
        loadImageAsyncRx(from: IMAGE_URL)
            .subscribe { (img,width,height) in
                DispatchQueue.main.async {
                    self.imageView.image = img
                }
            }
    }

    private func loadImage(from imageUrl: String) -> UIImage? {
        guard let url = URL(string: imageUrl) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }

        let image = UIImage(data: data)
        return image
    }
    
    private func loadImageAsync(from imageUrl:String,completion:@escaping (UIImage?,CGFloat,CGFloat) -> Void) {
        DispatchQueue.global(qos: .default).async {
            let image = self.loadImage(from: imageUrl)
            completion(image,image?.size.width ?? 0.0 , image?.size.height ?? 0.0)
        }
    }
    
    private func loadImageAsyncRx(from imageUrl:String) -> Observable<(UIImage?,CGFloat,CGFloat)> {
        return Observable.create { [weak self] emitter in
            guard let self = self else { return Disposables.create() }
            self.loadImageAsync(from: imageUrl) { img, width, height in
                emitter.onNext((img,width,height))
            }
            return Disposables.create()
        }
    }
}
