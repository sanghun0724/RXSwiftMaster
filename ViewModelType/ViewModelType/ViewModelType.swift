//
//  ViewModelType.swift
//  ViewModelType
//
//  Created by sangheon on 2022/07/17.
//

import RxSwift

protocol ViewModelType {
    associatedtype Dependency
    associatedtype Input
    associatedtype Output
    
    var dependency: Dependency { get }
    var disposeBag: DisposeBag { get set }
    
    
    init(dependency: Dependency)
    func transform(input: Input) -> Output
}
