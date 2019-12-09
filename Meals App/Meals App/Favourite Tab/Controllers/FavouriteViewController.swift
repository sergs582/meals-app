

import UIKit

class FavouriteViewController: UIViewController{

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var RecipesTable: UITableView!
    
    var viewModel = FavouriteViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.customTitleColor()
        
        RecipesTable.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "FavouriteCell")
        RecipesTable.delegate = self
        RecipesTable.dataSource = self
    }
  
    @IBAction func segmentChanged(_ sender: Any){
        
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


extension FavouriteViewController : UITableViewDataSource, UITableViewDelegate {
    
    

    //    var imageNames : [String]?
    //    var titles : [String]?
    //    var descriptions : [String]?

    //        self.imageNames = imageNamesArray
    //        self.titles = titlesArray
    //        self.descriptions = descriptionsArray
            
      

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.recipesCount()
          }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let view = storyboard?.instantiateViewController(withIdentifier: "recipe") as! RecipeViewController
            view.viewModel = viewModel.recipeViewModel
            navigationController?.pushViewController(view, animated: true)
        }


        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! RecipeCell
            cell.imageURL = viewModel.imageURL(at: indexPath.row)
            cell.titleText = viewModel.recipeTitle(at: indexPath.row)
            cell.descriptionText = viewModel.recipeCuisine(at: indexPath.row)
            
            cell.commonInit()
            return cell
          }
    }


