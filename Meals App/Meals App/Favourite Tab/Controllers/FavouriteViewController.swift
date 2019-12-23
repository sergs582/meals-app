

import UIKit

class FavouriteViewController: UIViewController{

    
    @IBOutlet weak var recipesTable: UITableView!
    
    var viewModel = FavouriteViewViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.update()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        recipesTable.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "FavouriteCell")
        recipesTable.delegate = self
        recipesTable.dataSource = self
        
        viewModel.recipes.bind { [unowned self] _ in
            self.recipesTable.reloadData()
        }
    }
}


extension FavouriteViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipesCount()
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = storyboard?.instantiateViewController(withIdentifier: "recipe") as! RecipeViewController
        view.viewModel = RecipeViewViewModel(savedRecipe: viewModel.recipes.value![indexPath.row])
        navigationController?.pushViewController(view, animated: true)
    }
        
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            viewModel.deleteRecipeWith(index: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! RecipeCell
            
        cell.imageData = viewModel.recipeImage(at: indexPath.row)
        cell.titleText = viewModel.recipeTitle(at: indexPath.row)
        cell.descriptionText = viewModel.recipeCuisine(at: indexPath.row)
            
        cell.commonInit()
        return cell
    }
}


