//
//  CompositonRoot.swift
//  StockTutorial
//
//  Created by sangheon on 2021/12/22.
//

import Foundation

struct AppDependency {
    let mainCoordinator:MainCoordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        
        //Repo는 singletion 형태로쓰기 때문에 빼줌
        let stockRepository:StockRepository = StockRepositoryImpl()
        //StockListControllerFactory 만들기 대장전
        let StockListControllerFactory: () -> StockListController = {
            let usecase = StockUseCase(stockRepository: stockRepository)
            let viewModel = StockListViewModel(usecase: usecase)
            return .init(dependency: .init(viewModel: viewModel))
        }
        
        let stockDetailControllerFactory:(Stock) -> StockDetailController = { stock in
            return .init(dependency: .init(stock: stock))
        }
        
        let mainCoordinator:MainCoordinator = .init(dependency: .init(stockListControllerFactory: StockListControllerFactory, stockDetatilControllerFactory: stockDetailControllerFactory))
        
        return .init(mainCoordinator: mainCoordinator)
    }
}
//H4ZRG44U4X1T6VSV
