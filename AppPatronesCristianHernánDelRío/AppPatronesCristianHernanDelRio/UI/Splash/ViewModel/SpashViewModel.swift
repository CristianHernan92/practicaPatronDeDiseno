import Foundation

//PROTOCOL
protocol SpashViewModelProtocol{
    func viewDidAppear()
    func viewDidDisappear()
}

final class SpashViewModel{
    //viewController
    weak var viewController: SplashProtocol? = nil
}

//EXTENSION
extension SpashViewModel: SpashViewModelProtocol{
    func viewDidAppear() {
        viewController?.startAnimatingOfActivityIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)){
            self.viewController?.showLogin()
        }
    }
    
    func viewDidDisappear() {
            viewController?.stopAnimatingOfActivityIndicator()
    }
}
