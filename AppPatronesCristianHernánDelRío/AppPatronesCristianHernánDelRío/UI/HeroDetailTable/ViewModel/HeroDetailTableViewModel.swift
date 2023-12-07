import Foundation

//PROTOCOL
protocol HeroDetailTableViewModelProtocol{
    func onViewLoaded()
    func getData()->HeroDetail
    func getTransformationsList()->[HeroTransformation]
}

final class HeroDetailTableViewModel{
    //viewController
    private let viewController:HeroDetailTableProtocol
    private let data:HeroDetail
    private var transformationsListData:[HeroTransformation] = []
    init(viewController:HeroDetailTableProtocol,data: HeroDetail) {
        self.viewController = viewController
        self.data = data
    }
}

//EXTENSION
extension HeroDetailTableViewModel:HeroDetailTableViewModelProtocol{
    func onViewLoaded() {
        //creo un "DispatchGrpup" para hacer que se espere a que finalice las tarea asincrónica
        let group = DispatchGroup()
        DragonBallZNetworkModel.getTransformationsList(heroId: self.data.id) { [weak self] data in
            defer{
                group.leave()
            }
            self?.transformationsListData = data
        }
        group.wait()
        DispatchQueue.main.async {
            self.viewController.reloadData()
        }
    }
    
    func getData()->HeroDetail{
        return self.data
    }
    
    func getTransformationsList() -> [HeroTransformation] {
        return self.transformationsListData
    }
}
