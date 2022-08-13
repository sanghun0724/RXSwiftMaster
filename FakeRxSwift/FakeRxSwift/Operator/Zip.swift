//
//  Zip.swift
//  FakeRxSwift
//
//  Created by sangheon on 2022/08/13.
//

import Foundation

extension ObservableType {
    func zip<O: ObservableType, U>(with other: O, combine: @escaping (E, O.E) -> U) -> Observable<U> {
        return Observable<U> { observer in
            let compositeDisposable = CompositeDisposable()

            var myBuffer = [E]()
            var otherBuffer = [O.E]()
            var completions: (my: Bool, other: Bool) = (false, false)

            func onNext() {
                // 들어온 값들을 꺼내어 next 이벤트를 전달
                guard !myBuffer.isEmpty && !otherBuffer.isEmpty else { return }
                Swift.zip(myBuffer, otherBuffer)
                    .map { combine($0, $1) }
                    .forEach {
                        myBuffer.removeFirst()
                        otherBuffer.removeFirst()
                        observer.on(.next($0))
                }
            }

            func onCompleted() {
                // 두 값이 true라면 completed 이벤트를 observer에 전달
                if completions.my && completions.other {
                    observer.on(.completed)
                }
            }

            let selfDisposable = self.subscribe(observer: Observer { event in
                let lock = NSLock()
                defer { lock.unlock() }

                switch event {
                case let .next(e):
                    myBuffer.append(e)
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
                    otherBuffer.append(e)
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
