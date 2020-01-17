

import UIKit
import Kingfisher

class RecipeCell: UITableViewCell {

    
    @IBOutlet weak var imageForCell: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var shortDescription: UILabel!
    
    var imageURL : URL?
    var titleText : String?
    var descriptionText : String?
    var imageData : Data?
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func commonInit() {
        title.text = titleText
        shortDescription.text = descriptionText
        
        if let imageURL = imageURL{
            imageForCell.kf.setImage(with: imageURL)
        }else if let data = imageData{
            imageForCell.image = UIImage(data: data)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
