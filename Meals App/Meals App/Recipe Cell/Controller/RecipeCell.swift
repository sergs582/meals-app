

import UIKit

class RecipeCell: UITableViewCell {

    
    @IBOutlet weak var imageForCell: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var shortDescription: UILabel!
    
    var imageURL : URL?
    var titleText : String?
    var descriptionText : String?
    var imageData : UIImage? {
        didSet{
            imageForCell.image = imageData
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func commonInit(){
        title.text = titleText
        shortDescription.text = descriptionText
        
        if let imageURL = imageURL{
      DispatchQueue.global().async {
        if let data = try? Data(contentsOf: imageURL),
            let image = UIImage(data: data){
            
            DispatchQueue.main.async {
            
            self.imageForCell.image = image
            }
        

        }
        
        }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
