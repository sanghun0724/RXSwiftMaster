//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import RxSwift
import SwiftyJSON
import UIKit

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

class 나중에생기는스트링데이터 {
    let _job: (@escaping (String) -> Void ) -> Void
    
    init(_ job: @escaping (@escaping (String) -> Void) -> Void) {
        _job = job
    }
    
    func 오겠지(_ f: @escaping (String) -> Void) -> Void {
        DispatchQueue.global().async {
            self._job(f) //매개변수에 있는 식 받아서 job에대가 적용
            //f 에서 치는 코드들 (매개변수)은 job 안에서 치는거랑 같음!!!!!!
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var editView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }
    
    func getJson2() -> 나중에생기는스트링데이터 {
        return 나중에생기는스트링데이터() { f in
            let url = URL(string: MEMBER_LIST_URL)!
            let data = try! Data(contentsOf: url)
            let json = String(data:data,encoding: .utf8)!
            f(json)
        }
    }
    
    func getJson3() -> Observable<String> {
        
        let ob2:Observable<JSON> =
            Observable.just(MEMBER_LIST_URL) //String
            .map { URL(string: $0)! } //URL
            .map { try Data(contentsOf: $0) } //Data
            .map {JSON($0)}
            .share()
        
        let ob3 = ob2
            .flatMap { Observable.from($0.arrayValue) } //JSON
            .map { $0["name"].stringValue } //JSON
            .map { $0 + "\n" }
        
        let ob4 = ob2
            .flatMap { Observable.from($0.arrayValue) }
            .map { $0["id"].intValue } //JSON
            .map { "\($0)\n" }
        
        ob3.subscribe()
        ob4.subscribe()
        //이렇게 해버리면 ob2가 2번 작동되어서 2번 다운로드 하게됨
        // 그래서 중복을 없애기 위해 shared()를 쓴것 (중간의 스트림에서 뿌리처럼 뻐져나오게)
        
        return Observable.just(MEMBER_LIST_URL) //String
            .map { URL(string: $0)! } // url
            .map { try Data(contentsOf: $0) } //Data
            .map { JSON($0) } //Json
            .flatMap { Observable.from($0.arrayValue) } //JSON
            .map { $0["name"].stringValue} //JSON
            .map { $0 + "\n"}
    }
    

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)

        let url = URL(string: MEMBER_LIST_URL)!
        let data = try! Data(contentsOf: url)
        let json = String(data: data, encoding: .utf8)
        self.editView.text = json
        
        self.setVisibleWithAnimation(self.activityIndicator, false)
    }
    
    // MARK: SYNC
    var disposable:Disposable?

    @IBAction func onSyncButtontap() {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)
        
        let 나중에생기는데이터 = getJson2()
        
        나중에생기는데이터.오겠지() { (json) in
            DispatchQueue.main.async {
                self.editView.text = json // 3
                self.setVisibleWithAnimation(self.activityIndicator, false) //4
            }
        }
        disposable = getJson3()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { json in
                self.editView.text = json
                self.setVisibleWithAnimation(self.activityIndicator, false)
            })
    }
}
