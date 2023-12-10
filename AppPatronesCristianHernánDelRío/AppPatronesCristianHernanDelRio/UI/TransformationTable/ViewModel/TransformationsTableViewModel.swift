import UIKit

//PROTOCOLS
protocol TransformationsTableViewModelProtocol{
    var dataCount:Int { get }
    func elementData(indexPatch: Int)-> HeroTransformation
    func elementDataImage(indexPatch: Int)-> UIImage
    func selectRowAt(indexPatch: Int)
}

final class TransformationsTableViewModel{
    //viewController
    weak var viewController:TransformationsTableProtocol?
    private let data:[HeroTransformation]
    
    init(viewController: TransformationsTableProtocol, data: [HeroTransformation]) {
        self.viewController = viewController
        self.data = data
    }
    
    private func getImageOfTransformation(data: HeroTransformation)->UIImage {
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
            guard let data = data else {
                print("No data error: \(String(describing: "El dato no es correcto"))")
                return
            }
            if let imageData = UIImage(data: data) {
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
extension TransformationsTableViewModel:TransformationsTableViewModelProtocol{
    var dataCount:Int{
        return self.data.count
    }

    func elementData(indexPatch: Int)-> HeroTransformation{
        return self.data[indexPatch]
    }
    
    func elementDataImage(indexPatch: Int) -> UIImage {
        return self.getImageOfTransformation(data: data[indexPatch])
    }

    func selectRowAt(indexPatch: Int) {
        if let viewController = self.viewController{
            viewController.showTransformationDetailTable(data: TransformationDetail(id: self.data[indexPatch].id, name: self.data[indexPatch].name, description: self.data[indexPatch].description, image: self.elementDataImage(indexPatch: indexPatch)))
        }
    }
}
