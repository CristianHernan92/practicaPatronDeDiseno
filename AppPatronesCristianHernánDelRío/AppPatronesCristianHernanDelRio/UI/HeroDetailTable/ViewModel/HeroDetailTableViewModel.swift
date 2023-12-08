import Foundation

//PROTOCOL
protocol HeroDetailTableViewModelProtocol{
    func onViewLoaded()
    func getData()->HeroDetail
    func getTransformationsListData()->[HeroTransformation]
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
    
    private func getTransformationsList(){
        //creo un "DispatchGrpup" para hacer que se espere a que termine el foreach con sus tareas asincrónicas
        let group = DispatchGroup()
        group.enter()
        DragonBallZNetworkModel.getTransformationsList(heroId: self.data.id) { [weak self] data in
            defer{
                group.leave()
            }
            self?.transformationsListData = data
        }
        group.wait()
    }
}

//EXTENSION
extension HeroDetailTableViewModel:HeroDetailTableViewModelProtocol{
    func onViewLoaded() {
        self.getTransformationsList()
        DispatchQueue.main.async {
            self.viewController.reloadData()
        }
    }
    
    func getData()->HeroDetail{
        return self.data
    }
    
    func getTransformationsListData() -> [HeroTransformation] {
        return self.transformationsListData
    }
}
