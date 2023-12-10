import Foundation

//PROTOCOL
protocol LoginViewModelProtocol{
    func buttonClicked(email: String, password: String)
}

final class LoginViewModel{
    //viewController
    weak var viewController: LoginMethodsProtocol? = nil
    
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
    func buttonClicked(email: String, password: String) {
            self.login(email: email, password: password) {
                self.viewController?.pushHeroTable()
            }
    }
}
