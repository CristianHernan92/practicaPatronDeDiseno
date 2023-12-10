import UIKit

//PROTOCOL
protocol HeroesTableViewModelProtocol{
    func onViewLoaded()
    var dataCount:Int { get }
    func elementData(indexPatch: Int)-> Hero
    func elementDataImage(indexPatch: Int)-> UIImage
    func selectRowAt(indexPatch: Int)
}

final class HeroesTableViewModel{
    //viewController
    weak var viewController:HeroesTableProtocol? = nil
    private var data: [Hero] = []
    
    private func getHeroesList(){
        DragonBallZNetworkModel.getHeroesList { data in
            self.data = data
            self.viewController?.reloadData()
        }
    }
    
    private func getImageOfHeroe(data: Hero)->UIImage{
        var image=UIImage()
        let group=DispatchGroup()
        group.enter()
        let task = URLSession.shared.dataTask(with: data.photo) { (data, response, error) in
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
            if let imageData = UIImage(data: data){
                image=imageData
            }
            group.leave()
        }
        task.resume()
        group.wait()
        return image
    }
}

//EXTENSION
extension HeroesTableViewModel:HeroesTableViewModelProtocol{
    func onViewLoaded() {
        self.getHeroesList()
    }
    
    var dataCount:Int{
        return self.data.count
    }
    
    func elementDataImage(indexPatch: Int)-> UIImage{
        return getImageOfHeroe(data: data[indexPatch])
    }
    
    func elementData(indexPatch: Int)->Hero{
        return self.data[indexPatch]
    }
    
    func selectRowAt(indexPatch: Int) {
        self.viewController?.showHeroDetailTable(data: HeroDetail(id: self.data[indexPatch].id, name: self.data[indexPatch].name, description: self.data[indexPatch].description, image: self.elementDataImage(indexPatch: indexPatch)))
    }
}
