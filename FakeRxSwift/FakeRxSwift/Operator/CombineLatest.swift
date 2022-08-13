//
//  CombineLatest.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/13.
//

import Foundation

extension ObservableType {
    func combineLatest<O: ObservableType, U>(with other: O, combine: @escaping (E, O.E) -> U) -> Observable<U> {
        return Observable<U> { observer in
            let compositeDisposable = CompositeDisposable()
            
            var elements: (my: E?, other: O.E?)
            var completions: (my: Bool, other: Bool) = (false, false)
            
            func onNext() {
                if let myElement = elements.my, let otherElement = elements.other {
                    let combination = combine(myElement, otherElement)
                    observer.on(.next(combination))
                }
            }
            
            func onCompleted() {
                // 두값이 true라면 completed event를 observer에 전달
                if completions.my && completions.other {
                    observer.on(.completed)
                }
            }
            
            let selfDisposable = self.subscribe(observer: Observer { event in
                let lock = NSLock()
                defer { lock.unlock() }
                
                switch event {
                case let .next(e):
                    elements.my = e
                    onNext()
                case let .error(error):
                    observer.on(.error(error))
                case .completed:
                    completions.my = true
                    onCompleted()
                }
            })
            
            let otherDisposable = other.subscribe(observer: Observer { event in
                let lock = NSLock()
                defer { lock.unlock() }
                
                switch event {
                case let .next(e):
                    elements.other = e
                    onNext()
                case let .error(error):
                    observer.on(.error(error))
                case .completed:
                    completions.other = true
                    onCompleted()
                }
            })
            
            compositeDisposable.add(disposable: selfDisposable)
            compositeDisposable.add(disposable: otherDisposable)
            
            return compositeDisposable
        }
    }
}
