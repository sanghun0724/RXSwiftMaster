//
//  RxCLLocationManagerDelegateProxy.swift
//  RxWeatherApp
//
//  Created by sangheon on 2021/10/04.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

extension CLLocationManager: HasDelegate {
    public typealias Delegate = CLLocationManagerDelegate
}

//여기서 Observable이 생성되고 구독이 된 직후 CLLocationManager 인스턴스에 열결하는 Proxy가 될 것이다.
class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager,CLLocationManagerDelegate>,DelegateProxyType
                                        ,CLLocationManagerDelegate {
    public weak private(set) var locationManager: CLLocationManager?

    public init(locationManager: ParentObject) {
        self.locationManager = locationManager
        super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
       }

    static func registerKnownImplementations() {
        self.register {
            RxCLLocationManagerDelegateProxy(locationManager: $0)
        }
    }
} //위 두가지 함수를 이용해서 delegate를 초기화하고, 모든구현 등록가능

extension Reactive where Base: CLLocationManager {
    public var delegate: DelegateProxy<CLLocationManager,CLLocationManagerDelegate> {
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
    }

    var didUpdateLocations:Observable<[CLLocation]> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:))).map {
            parameters in
            return parameters[1] as! [CLLocation]
        } //didupdateLocation함수의 모든호출을 수신하고 데이터를 가져와서 array로 캐스팅 후 Observable형태로 리턴
    }
} //rx키워드를 통해 CLLocationManager 인스턴스의 method들을 펼쳐놓을것 여기서

