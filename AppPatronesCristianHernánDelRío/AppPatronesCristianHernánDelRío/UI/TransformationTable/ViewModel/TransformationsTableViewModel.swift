import UIKit

//PROTOCOLS
protocol TransformationsTableViewModelProtocol{
    func onViewLoaded()
    func dataCount()->Int
    func getCellData(indexPatch: Int)-> (name:String,description:String,image:UIImage)
    func selectRowAt(indexPatch: Int)
}

final class TransformationsTableViewModel{
    //viewController
    private let viewController:TransformationsTableProtocol
    private let heroTransformationList:[HeroTransformation]
    private var data:[(id:String,name:String,description:String,image:UIImage)] = []
    
    init(viewController: TransformationsTableProtocol, data: [HeroTransformation]) {
        self.viewController = viewController
        self.heroTransformationList = data
    }
}

//EXTENSION
extension TransformationsTableViewModel:TransformationsTableViewModelProtocol{
    func onViewLoaded() {
        heroTransformationList.forEach { heroTransformation in
            let task = URLSession.shared.dataTask(with: heroTransformation.photo) { (data, response, error) in
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
                if let image = UIImage(data: data){
                    self.data.append((id: heroTransformation.id, name: heroTransformation.name, description: heroTransformation.description, image: image))
                }
            }
            task.resume()
        }
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
        viewController.showTransformationDetailTable(data: TransformationDetail(id: self.data[indexPatch].id, name: self.data[indexPatch].name, description: self.data[indexPatch].description, image: self.data[indexPatch].image))
    }
}
