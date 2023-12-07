import UIKit

struct HeroDetail {
    var id: String
    var name: String
    var description: String
    var image: UIImage
    
    init(id: String, name: String, description: String, image: UIImage) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
    }
}
