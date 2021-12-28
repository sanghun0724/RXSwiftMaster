import RxSwift
import Combine

class StockListViewModel:BaseViewModel{
    @Published var stocks:[Stock] = []
    @Published var errorMessage:String?
    @Published var loading = false
    @Published var isEmpty = false
    var currentStocks:[Stock] = []
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
            self.currentStocks = stockResult.items
            self.stocks = stockResult.items
        }.store(in: &subscriber)

    }
    
    
    init(usecase:StockUseCase) {
        self.usecase = usecase
        super.init()
        self.reduce()
    }
    
    //stock값이 있냐 없냐 판단해서 isEmpty값 넣어줌
    func reduce() {
        $stocks.sink { [unowned self] stocks in
            if stocks.count == 0 {
                self.isEmpty = true
            } else {
                self.isEmpty = false
            }
        }.store(in: &subscriber)
    }
    
}
