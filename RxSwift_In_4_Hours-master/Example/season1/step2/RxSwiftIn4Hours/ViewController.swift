//
//  ViewController.swift
//  RxSwiftIn4Hours
//
//  Created by iamchiwon on 21/12/2018.
//  Copyright © 2018 n.code. All rights reserved.
//

import RxSwift
import UIKit

class ViewController: UITableViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  //이렇게 Stream들로 async programming 하겠다!!!!!!!
    @IBAction func exJust1() {
       let _ = Observable<String>.create { observer in
            observer.onNext("Hello world")
            observer.onCompleted()
            return Disposables.create()
        }
        .subscribe { event in
            switch event {
                case .next(let text):
                print(text)
            case .completed:
                break
            case .error(let _):
                break
            }
        }
        
        //SUGAR
        Observable.just("Hello World")
            .subscribe(onNext:{ text in
                print($0)
            })
    }

    @IBAction func exJust2() {
        Observable.just(["Hello", "World"])
            .subscribe(onNext: { arr in
                print(arr)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exFrom1() {
        Observable.from(["RxSwift", "In", "4", "Hours"])
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exMap1() {
        Observable.just("Hello")
            .map { str in "\(str) RxSwift" }
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exMap2() {
        Observable.from(["with", "곰튀김"])
            .map { $0.count }
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func exFilter() {
        Observable.from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
            .filter { $0 % 2 == 0 }
            .subscribe(onNext: { n in
                print(n)
            })
            .disposed(by: disposeBag)
    }
    
    private func rxImageLoder(_ src:URL) -> Observable<UIImage?> {
        return Observable.create { emitter in
            let task = URLSession.shared.dataTask(with: src) { (data, respone, error) in
                if error != nil {
                    emitter.onError(error!)
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    emitter.onCompleted()
                    return
                }
                let image = UIimage(data:data)
                emitter.onNext(image)
                
            }
            task.resume()
            return Disposables.create()
            task.cancel()
        }
    }

    @IBAction func exMap3() {
        Observable.just("800x600")
            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .default)) //concurrent 스케줄러에
            .map { $0.replacingOccurrences(of: "x", with: "/") }
            .map { "https://picsum.photos/\($0)/?random" }
            .map { URL(string: $0) }
            .filter { $0 != nil } //nil check 했으니
            .map { $0! } //강제 언래핑 쌉가능
            .subscribeOn(ConcurrentMainScheduler.instance) //subscribe 받는 순간부터 이 스케줄러로 돌리겠다 라는 소리
            .map { try Data(contentsOf: $0) }
            .map { UIImage(data: $0) }
            .observeOn(MainScheduler.instance) //image는 메인스케줄러에
            .subscribe(onNext: { image in
                self.imageView.image = image
            })
            .disposed(by: disposeBag)
    }
}

//side effet 작성은 -> subscribe와 do 로
