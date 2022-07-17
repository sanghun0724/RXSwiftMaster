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
    
    init(dependency: Dependency)
    func transform(input: Input) -> Output
}
