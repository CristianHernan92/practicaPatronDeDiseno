import UIKit

//PROTOCOL
protocol SplashProtocol{
    func startAnimatingOfActivityIndicator()
    func stopAnimatingOfActivityIndicator()
    func showLogin()
}

final class Splash: UIViewController {
    //viewModel
    var viewModel: SpashViewModelProtocol? = nil

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel?.viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.viewModel?.viewDidDisappear()
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
        DispatchQueue.main.async {
            self.navigationController?.showLogin()
        }
    }
}


