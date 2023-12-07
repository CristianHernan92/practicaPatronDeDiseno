import Foundation

//PROTOCOL
protocol TransformationDetailTableViewModelProtocol{
    func onViewLoaded()
    func getData()->TransformationDetail
}

final class TransformationDetailTableViewModel{
    //viewController
    private let viewController:TransformationDetailTableProtocol
    private let data:TransformationDetail
    
    init(viewController:TransformationDetailTableProtocol,data: TransformationDetail) {
        self.viewController = viewController
        self.data = data
    }
}

//EXTENSION
extension TransformationDetailTableViewModel:TransformationDetailTableViewModelProtocol{
    func onViewLoaded() {
        DispatchQueue.main.async {
            self.viewController.reloadData()
        }
    }
    func getData()->TransformationDetail{
        return self.data
    }
}
