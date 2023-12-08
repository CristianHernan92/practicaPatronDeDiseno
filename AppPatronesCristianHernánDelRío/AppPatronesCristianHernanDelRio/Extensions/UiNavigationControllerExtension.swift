import UIKit

extension UINavigationController{
    func showLogin(){
        DispatchQueue.main.async {
            let loginViewController = Login()
            loginViewController.viewModel = LoginViewModel(viewController: loginViewController)
            self.pushViewController(
                loginViewController,
                animated: true)
        }
    }
    func showHeroTable(){
        DispatchQueue.main.async {
            let heroesTable = HeroesTable()
            heroesTable.viewModel = HeroesTableViewModel(viewController: heroesTable)
            self.pushViewController(
                heroesTable,
                animated: true)
        }
    }
    func showHeroDetailTable(with data: HeroDetail){
        let heroDetailTable = HeroDetailTable()
        heroDetailTable.viewModel = HeroDetailTableViewModel(viewController: heroDetailTable,data: data)
        DispatchQueue.main.async {
            self.pushViewController(
                heroDetailTable,
                animated: true)
        }
    }
    func showTransformationTable(with data: [HeroTransformation]){
        let transformationsTable = TransformationsTable()
        transformationsTable.viewModel = TransformationsTableViewModel(viewController: transformationsTable, data: data)
        DispatchQueue.main.async {
            self.pushViewController(
                transformationsTable,
                animated: true)
        }
    }
    func showTransformationDetailTable(with data: TransformationDetail){
        let transformationDetailTable = TransformationDetailTable()
        transformationDetailTable.viewModel = TransformationDetailTableViewModel(viewController: transformationDetailTable,data: data)
        DispatchQueue.main.async {
            self.pushViewController(
                transformationDetailTable,
                animated: true)
        }
    }
}
