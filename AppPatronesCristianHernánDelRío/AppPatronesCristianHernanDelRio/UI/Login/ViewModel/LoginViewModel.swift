import Foundation

//PROTOCOL
protocol LoginViewModelProtocol{
    func loginButtonClicked(email: String, password: String)
}

final class LoginViewModel{
    //viewController
    private let viewController: LoginMethodsProtocol
    
    init(viewController: LoginMethodsProtocol) {
        self.viewController = viewController
    }
    
    //login
    //llamada a la api del login
    private func login(email: String, password: String, completion: @escaping () -> Void) {
        DragonBallZNetworkModel.login(email: email, password: password) {
            completion()
        }
    }

}

//EXTENSION
extension LoginViewModel:LoginViewModelProtocol{
    func loginButtonClicked(email: String, password: String) {
            self.login(email: email, password: password) {
                self.viewController.pushHeroTable()
            }
    }
}
