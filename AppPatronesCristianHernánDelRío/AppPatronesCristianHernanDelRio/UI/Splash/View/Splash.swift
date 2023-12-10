import UIKit

//PROTOCOL
protocol SplashProtocol:AnyObject{
    func startAnimatingOfActivityIndicator()
    func stopAnimatingOfActivityIndicator()
    func showLogin()
}

final class Splash: UIViewController {
    //viewModel
    let viewModel: SpashViewModelProtocol
    
    init(viewModel: SpashViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.viewDidDisappear()
    }

}

//EXTENSION
extension Splash: SplashProtocol{
    func startAnimatingOfActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimatingOfActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func showLogin(){
        let viewModel = LoginViewModel()
        let loginViewController = Login(viewModel: viewModel)
        viewModel.viewController = loginViewController
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(
                loginViewController,
                animated: true
            )
        }
    }
}


