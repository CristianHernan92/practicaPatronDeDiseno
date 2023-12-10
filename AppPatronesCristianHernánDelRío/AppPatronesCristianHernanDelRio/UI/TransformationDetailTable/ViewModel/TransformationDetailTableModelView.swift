import Foundation

//PROTOCOL
protocol TransformationDetailTableViewModelProtocol{
    func onViewLoaded()
    var elementData:TransformationDetail { get }
}

final class TransformationDetailTableViewModel{
    //viewController
    weak var viewController:TransformationDetailTableProtocol?
    private let data:TransformationDetail
    
    init(viewController:TransformationDetailTableProtocol,data: TransformationDetail) {
        self.viewController = viewController
        self.data = data
    }
}

//EXTENSION
extension TransformationDetailTableViewModel:TransformationDetailTableViewModelProtocol{
    func onViewLoaded() {
        self.viewController?.reloadData()
    }
    var elementData:TransformationDetail{
        return self.data
    }
}
