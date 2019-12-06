
import UIKit

class RecentSearchHeader: UITableViewHeaderFooterView {

  
    weak var recentDelegate : RecentDelegate?
    
    @IBAction func clear(_ sender: Any) {
        recentDelegate?.clearRecent()
    }
}
