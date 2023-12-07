import UIKit

extension UINavigationController{
    func showHeroTable(){
        DispatchQueue.main.async {
            let heroesTable = HeroesTable()
            let heroesTableViewModel = HeroesTableViewModel(viewController: heroesTable)
            heroesTable.viewModel = heroesTableViewModel
            self.pushViewController(
                heroesTable,
                animated: true)
        }
    }
    func showHeroDetailTable(with data: HeroDetail){
        let heroDetailTable = HeroDetailTable()
        let heroDetailTableViewModel = HeroDetailTableViewModel(viewController: heroDetailTable,data: data)
        heroDetailTable.viewModel = heroDetailTableViewModel
        DispatchQueue.main.async {
            self.pushViewController(
                heroDetailTable,
                animated: true)
        }
    }
    func showTransformationTable(with data: [HeroTransformation]){
        let transformationsTable = TransformationsTable()
        let transformationsTableViewModel = TransformationsTableViewModel(viewController: transformationsTable, data: data)
        transformationsTable.viewModel = transformationsTableViewModel
        DispatchQueue.main.async {
            self.pushViewController(
                transformationsTable,
                animated: true)
        }
    }
    func showTransformationDetailTable(with data: TransformationDetail){
        let transformationDetailTable = TransformationDetailTable()
        let heroDetailTableViewModel = TransformationDetailTableViewModel(viewController: transformationDetailTable,data: data)
        transformationDetailTable.viewModel = heroDetailTableViewModel
        DispatchQueue.main.async {
            self.pushViewController(
                transformationDetailTable,
                animated: true)
        }
    }
}
