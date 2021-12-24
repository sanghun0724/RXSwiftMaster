import RxSwift
import Combine

class StockListViewModel {
    @Published var stocks:[Stock] = []
    @Published var errorMessage:String?
    @Published var loading = false
    var subscriber:Set<AnyCancellable> = .init()
    let usecase:StockUseCase
    
    func searchQueryChanged(query:String) {
        loading = true
        usecase.fetchStocksPublisher(keyword: query).sink { [unowned self] (completion) in
            self.loading = false
            switch completion {
            case .failure(let error):
            self.errorMessage = error.localizedDescription
            case .finished: break;
            }
        } receiveValue: { (stockResult) in
            self.stocks = stockResult.items
        }.store(in: &subscriber)

    }
    
    
    init(usecase:StockUseCase) {
        self.usecase = usecase
    }
    
}
