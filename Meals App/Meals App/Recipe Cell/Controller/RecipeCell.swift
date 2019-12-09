

import UIKit

class RecipeCell: UITableViewCell {

    
    @IBOutlet weak var imageForCell: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var shortDescription: UILabel!
    
    var imageURL : URL?
    var titleText : String?
    var descriptionText : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func commonInit(){
        title.text = titleText
        shortDescription.text = descriptionText
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
