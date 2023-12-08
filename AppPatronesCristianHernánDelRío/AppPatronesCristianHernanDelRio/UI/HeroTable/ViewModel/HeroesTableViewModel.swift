import UIKit

//PROTOCOL
protocol HeroesTableViewModelProtocol{
    func onViewLoaded()
    func dataCount()->Int
    func getCellData(indexPatch: Int)-> (name:String,description:String,image:UIImage)
    func selectRowAt(indexPatch: Int)
}

final class HeroesTableViewModel{
    //viewController
    private let viewController:HeroesTableProtocol
    private var data:[(id:String,name:String,description:String,image:UIImage)] = []
    
    init(viewController: HeroesTableProtocol) {
        self.viewController = viewController
    }
    
    private func getHeroesList(){
        //creo un "DispatchGrpup" para hacer que se espere a que termine el foreach con sus tareas asincrónicas
        let group = DispatchGroup()
        group.enter()
        DragonBallZNetworkModel.getHeroesList { data in
            defer{
                group.leave()
            }
            data.forEach { hero in
                let task = URLSession.shared.dataTask(with: hero.photo) { (data, response, error) in
                    guard error == nil else {
                        print("Error: \(String(describing: error))")
                        return
                    }
                    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                        print("Response Error: \(String(describing: response))")
                        return
                    }
                    guard let data else {
                        print("No data error: \(String(describing: "El dato no es correcto"))")
                        return
                    }
                    if let image=UIImage(data: data){
                        self.data.append((id: hero.id, name: hero.name, description: hero.description, image: image))
                    }
                }
                task.resume()
            }
        }
        group.wait()
    }
}

//EXTENSION
extension HeroesTableViewModel:HeroesTableViewModelProtocol{
    func onViewLoaded() {
        self.getHeroesList()
        DispatchQueue.main.async {
            self.viewController.reloadData()
        }
    }
    
    func dataCount()->Int{
        return self.data.count
    }
    
    func getCellData(indexPatch: Int)-> (name:String,description:String,image:UIImage){
        return (name:self.data[indexPatch].name,description:self.data[indexPatch].description,image:self.data[indexPatch].image)
    }
    
    func selectRowAt(indexPatch: Int) {
        viewController.showHeroDetailTable(data: HeroDetail(id: self.data[indexPatch].id, name: self.data[indexPatch].name, description: self.data[indexPatch].description, image: self.data[indexPatch].image))
    }
    
}
