//
//  ViewModel.swift
//  ViewModelType
//
//  Created by sangheon on 2022/07/17.
//

import RxSwift
import RxCocoa

final class ViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    var dependency: Dependency
    
    struct Dependency {
        let dummy: Int
    }
    
    struct Input {
        var didTapBtn: Observable<Void>
    }

    struct Output {
        var countNum: Driver<Int>
    }
    
    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func transform(input: Input) -> Output {
        let count = BehaviorRelay(value: 0)
        
        input.didTapBtn.bind { _ in
            count.accept(count.value+1)
        }.disposed(by: disposeBag)
        
        return Output(countNum: count.asDriver(onErrorJustReturn: 0))
    }
}
