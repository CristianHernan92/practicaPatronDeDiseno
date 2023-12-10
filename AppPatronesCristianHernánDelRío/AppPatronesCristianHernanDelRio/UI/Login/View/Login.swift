import UIKit

//PROTOCOL
protocol LoginMethodsProtocol:AnyObject{
    func pushHeroTable()
}

final class Login: UIViewController {
    //viewModel
    let viewModel:LoginViewModelProtocol
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private weak var EmailTextField: UITextField!
    @IBOutlet private weak var PasswordTextField: UITextField!
    @IBAction private func LoginButtonAction(_ sender: UIButton) {
        if let email = EmailTextField.text, !email.isEmpty, let password = PasswordTextField.text, !password.isEmpty{
            viewModel.buttonClicked(email: email, password: password)
        }
    }
}

//EXTENSION
extension Login:LoginMethodsProtocol{
    func pushHeroTable() {
        DispatchQueue.main.async {
            let viewModel = HeroesTableViewModel()
            let heroesTable = HeroesTable(viewModel: viewModel)
            viewModel.viewController = heroesTable
            self.navigationController?.pushViewController(
                heroesTable,
                animated: true
            )
        }
    }
}
