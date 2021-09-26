//
//  ViewController.swift
//  RxWeatherApp
//
//  Created by sangheon on 2021/09/26.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
   @IBOutlet weak var searchCityName: UITextField!
   @IBOutlet weak var tempLabel: UILabel!
   @IBOutlet weak var humidityLabel: UILabel!
   @IBOutlet weak var iconLabel: UILabel!
   @IBOutlet weak var cityNameLabel: UILabel!
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        
        ApiController.shared.currentWeather(city: "RxSwift")
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                self.tempLabel.text = "\(data.temperature)"
                self.iconLabel.text = data.icon
                self.humidityLabel.text = "\(data.humidity)"
                self.cityNameLabel.text = data.cityName
            })
            .disposed(by: bag)//이는 뷰컨의 릴리즈 여부에 따라 구독을 취소/dispose하게 된다. 리소스 낭비를 막아줄뿐 아니라 예측하짐 못했던 이벤트 발생 또는 다른 부수작용들이 구독을 dispose하지않아 발생되지 않도록 막아준다.
        
        searchCityName.rx.text
            .filter { ($0 ?? "").count > 0 }
            .flatMapLatest{ text in
                return ApiController.shared.currentWeather(city: text ?? "Error")
                     .catchAndReturn(ApiController.Weather.empty) //에러 받아도 빈값을 방출하도록 설정 (중단되면안되니)
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                self.tempLabel.text = "\(data.temperature)C"
                self.iconLabel.text = data.icon
                self.humidityLabel.text = "\(data.humidity)%"
                self.cityNameLabel.text = data.cityName
            })
            .disposed(by: bag)
    }
    
    
    
    
    
    //Default
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()

     // Appearance.applyBottomLine(to: searchCityName)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }

    // MARK: - Style

    private func style() {
      view.backgroundColor = UIColor.black
      searchCityName.textColor = UIColor.ufoGreen
      tempLabel.textColor = UIColor.cream
      humidityLabel.textColor = UIColor.cream
      iconLabel.textColor = UIColor.cream
      cityNameLabel.textColor = UIColor.cream
    }

}

