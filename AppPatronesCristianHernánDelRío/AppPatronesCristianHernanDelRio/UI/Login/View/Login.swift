import UIKit

//PROTOCOL
protocol LoginMethodsProtocol{
    func pushHeroTable()
}

final class Login: UIViewController {
    //viewModel
    var viewModel:LoginViewModelProtocol? = nil
    
    @IBOutlet private weak var EmailTextField: UITextField!
    @IBOutlet private weak var PasswordTextField: UITextField!
    @IBAction private func LoginButtonAction(_ sender: UIButton) {
        if let email = EmailTextField.text, !email.isEmpty, let password = PasswordTextField.text, !password.isEmpty{
            self.viewModel?.loginButtonClicked(email: email, password: password)
        }
    }
}

//EXTENSION
extension Login:LoginMethodsProtocol{
    func pushHeroTable() {
        DispatchQueue.main.async {
            self.navigationController?.showHeroTable()
        }
    }
}
