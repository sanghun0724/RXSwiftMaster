//
//  ViewModel.swift
//  BindingTest
//
//  Created by sangheon on 2022/02/05.
//

import RxSwift
import RxCocoa
import RxAlamofire

class Const {
    public static let APIKey = "6126504f-0f3d-40db-b971-4be4ce248bf6"
}

class ViewModel {

    public let dogs = BehaviorRelay<[Dog]>(value: [])
    var currentDogs:[Dog] = []
    public let myError = BehaviorRelay<Error?>(value: nil)
    private let disposeBag = DisposeBag()
    let apiUrl = "https://api.thedogapi.com/v1/breeds"
    
    public func load() -> Void {
        let url = URL(string: apiUrl)!
        
        var request = URLRequest(url:url)
        request.method = .get
        request.headers = [
            "x-api-key":Const.APIKey,
            "Accept":"application/json"
        ]
        
        RxAlamofire.requestJSON(request).subscribe(onNext: { (respone,any) in
                do {
                    let data = try JSONSerialization.data(withJSONObject: any)
                    let dog = try JSONDecoder().decode([Dog].self, from: data)
                    self.dogs.accept(dog)
                    self.currentDogs = dog
                } catch let error {
                    self.myError.accept(error)
                }
            
        }).disposed(by: disposeBag)
        
}
    
}
