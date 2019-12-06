

import UIKit

class FavouriteViewController: UIViewController, RecipeResultsDelegate{

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var RecipesTable: FavouriteTable!
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.customTitleColor()
        RecipesTable.resultsDelegate = self
    }
  
    @IBAction func segmentChanged(_ sender: Any){
        
    }
    func didSelectResult(cell: UITableViewCell) {
        let view = storyboard?.instantiateViewController(withIdentifier: "recipe") as! RecipeViewController
        navigationController?.pushViewController(view, animated: true)
    }
    
}

extension UISegmentedControl{
    func customTitleColor(){
        var titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "SegmentedTitleColor")!]
        self.setTitleTextAttributes(titleTextAttributes, for: .normal)
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
}
