import Foundation

//PROTOCOL
protocol SpashViewModelProtocol{
    func viewDidAppear()
    func viewDidDisappear()
}

final class SpashViewModel{
    //viewController
    var viewController: SplashProtocol
    
    init(viewController: SplashProtocol) {
        self.viewController = viewController
    }
    
}

//EXTENSION
extension SpashViewModel: SpashViewModelProtocol{
    func viewDidAppear() {
        self.viewController.startAnimatingOfActivityIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){ [weak self] in
            self?.viewController.showLogin()
        }
    }
    
    func viewDidDisappear() {
        self.viewController.stopAnimatingOfActivityIndicator()
    }
    
    
}
