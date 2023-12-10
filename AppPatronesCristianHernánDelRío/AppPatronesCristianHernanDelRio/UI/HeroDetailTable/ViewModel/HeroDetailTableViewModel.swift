import Foundation

//PROTOCOL
protocol HeroDetailTableViewModelProtocol{
    func onViewLoaded()
    var elementData:HeroDetail { get }
    var listData:[HeroTransformation] { get }
}

final class HeroDetailTableViewModel{
    //viewController
    weak var viewController:HeroDetailTableProtocol?
    private let data:HeroDetail
    private var dataList:[HeroTransformation] = []
    init(viewController:HeroDetailTableProtocol,data: HeroDetail) {
        self.viewController = viewController
        self.data = data
    }
    
    private func getTransformationsList(completion: @escaping ()->Void){
        DragonBallZNetworkModel.getTransformationsList(heroId: self.data.id) { [weak self] data in
            self?.dataList = data
            completion()
        }
    }
}

//EXTENSION
extension HeroDetailTableViewModel:HeroDetailTableViewModelProtocol{
    func onViewLoaded() {
        self.getTransformationsList {
            self.viewController?.reloadData()
        }
    }
    
    var elementData:HeroDetail{
        return self.data
    }
    
    var listData:[HeroTransformation] {
        return self.dataList
    }
}
