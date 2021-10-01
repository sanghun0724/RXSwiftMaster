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
    @IBOutlet weak var indicaitorView:UIActivityIndicatorView!
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        
        let searchInput = searchCityName.rx.controlEvent(.editingDidEndOnExit).asObservable()
            .map{ self.searchCityName.text}
            .filter{ ($0 ?? "").count > 0 }
        
        
        ApiController.shared.currentWeather(city: "RxSwift")
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                self.tempLabel.text = "\(data.temperature)"
                self.iconLabel.text = data.icon
                self.humidityLabel.text = "\(data.humidity)"
                self.cityNameLabel.text = data.cityName
            })
            .disposed(by: bag)//이는 뷰컨의 릴리즈 여부에 따라 구독을 취소/dispose하게 된다. 리소스 낭비를 막아줄뿐 아니라 예측하짐 못했던 이벤트 발생 또는 다른 부수작용들이 구독을 dispose하지않아 발생되지 않도록 막아준다.
        
        //이제 search를 탭했을때만 text가져오고 apiRequest (수시로 가져오지않고 )
        let search = searchInput
            .flatMap { text in
                return ApiController.shared.currentWeather(city: text ?? "Error")
            }
            .asDriver(onErrorJustReturn: ApiController.Weather.empty) //Observable -> driver
        
        let running = Observable.from([
            searchInput.map{ _ in true },
            search.map { _ in false }.asObservable()
        ])
        .merge()
        .startWith(true) //observabel에 true요소 먼저하나 추가 시작하고 시작
        .asDriver(onErrorJustReturn: false)
        //true면 보여지고 false면 indicator stop
        
        
       let _ = running.asObservable().subscribe(onNext: { print($0)})
        
        running
            .skip(1)
            .drive(indicaitorView.rx.isAnimating)
            .disposed(by: bag)
        
        
        
        search.map { "\($0.temperature)C"}
            .drive(tempLabel.rx.text) //bindTo -> drive
            .disposed(by: bag)
        
        search.map {"\($0.humidity)"}
            .drive(humidityLabel.rx.text)
            .disposed(by: bag)
        
        search.map { "\($0.cityName)"}
            .drive(cityNameLabel.rx.text)
            .disposed(by: bag)
        
        search.map {"\($0.icon)" }
            .drive(iconLabel.rx.text)
            .disposed(by: bag)
        
        running
            .drive(tempLabel.rx.isHidden)
            .disposed(by: bag)
        
        running
            .drive(humidityLabel.rx.isHidden)
            .disposed(by: bag)
        
        running
            .drive(iconLabel.rx.isHidden)
            .disposed(by: bag)
        
        running
            .drive(cityNameLabel.rx.isHidden)
            .disposed(by: bag)
        
        
        searchCityName.keyboardType = .asciiCapable
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




//MARK: controlProperty와 Driver란?
/*
 -문서 : Traits는 Observable sequence 객체가 인터페이스 영역과 소통할 수 있도록 도와준다.
   ~ Trait는 에러를 방출할 수 없다
   ~ Trait는 메인 스케줄러에서 관찰한다
   ~ Trait는 메인 스케줄러에서 구독한다.
   ~ Trait는 부수작용을 공유한다
 - Trait 프레임워크의 주요소는 다음과 같다.
  ~ ControlProperty: 데이터와 유저 인터페이스를 연결할 때 rx extension을 통해 사용한 적이 있다.
  ~ ControlEvent: 텍스트필드에서 글자를 입력할 때 리턴버튼을 누르는 것과 같이,UI구성요소에서의 확실한 이벤트를 듣기 위해 사용한다. Control Event는 구성요소가 UIControlEvents를 현재 상태에 계속 두고 사용할 때 사용 가능하다.
  ~ Driver: 에러를 방출하지 않는 특별한 Observable이다. 모든 과정은 UI변경이 background 쓰레드에서 이뤄지는 것을 방지하기 위해 메인 쓰레드에서 이뤄진다.
 - Trait를 억지로 사용할 필요는 없다. 처음에는 순수한 Subject나 Observable만 쓰는 것도 나쁘지 않다. 하지만 약간 컴파일링 중에 또는 UI와 관련된 어떤 예정된 법칙을 체크하고 싶을 때, Trait는 아주 강력한 기능을 제공하며 시간 절약에도 좋다.
 
 - 모든 작업이 정확히 올바른 쓰레드에서 작동하고 있으며, 어떠한 에러도 발생하지 않아서 애러를 통한 구독중지도 일어나지 않는 어플리케이션을 만들어 봅시다.
 */


//MARK: RxCocoa와 dispose하기
/*
 - 왜 weak나 unowned 키워드를 클로져 내부에서 사용하지 않는걸까?
  ~ 왜냐하면 이 앱은 단일 뷰컨트롤러이고 메인뷰컨트롤러는 앱이 구동되는 동안은 항상 스크린에 띄워져 있기 때문이다. 따라서 메모리 낭비를 여기서는 걱정할 필요가 없다
 */

//MARK: RxCocoa에서의 unowned vs weak
/* RxCocoa와 RxSwift를 다룰때 unowned와 weak에 대한 개념은 어렵게 다가올 수 있다 .
 - 지금까지는 클로저가 추후에 이미 릴리즈된 self객체를 부를때를 대비해서 weak 키워드를 썼다. 이 때문에 self는 옵셔널이 되었다. unowned는 이런 옵셔널 self를 회피하고 싶을때 사용했다. 하지만 unowned를 쓸때는 해당 클로저가 호출되기 전에는 절대 해당 객체가 릴리즈 되지 않는다는 것을 보장해야한다. 그렇지 않으면 crash가 날 것이기 때문이다 (unowned는 무조건 해당객체에 값이 있어야 하기 때문에)
 - RxSwift, 특히 RxCocoa에서는 이부분에 대한 좋은 가이드 라인이 있다.
    - nothing: 절대 릴리즈 되지 않는 싱글톤 내부 또는 뷰컨트롤러 (root view controller 같은)
    - unowned: 클로저 작업이 실행된 후 릴리즈 되는 모든 뷰컨트롤러 내부
    - weak: 상기 두개 상황을 제외한 케이스
 (다만 raywenderlich는 unwened를 절대 쓰지 말라고 하고 있다)
*/
