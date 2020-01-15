

import UIKit
import RxSwift
import RxCocoa
class FavouriteViewController: UIViewController, UITableViewDelegate{

    
    @IBOutlet weak var recipesTable: UITableView!
    
    var viewModel = FavouriteViewViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.update()
    }
    
    var iterator = 0
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTable.dataSource = nil
        recipesTable.delegate = nil
        
        recipesTable.rx.setDelegate(self).disposed(by: disposeBag)
        recipesTable.rowHeight = 80
        
        recipesTable.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
        
        viewModel.recipes
            .bind(to: recipesTable.rx.items(cellIdentifier: "RecipeCell", cellType: RecipeCell.self)){
                row, recipe, cell in
                cell.imageData = recipe.image
                cell.titleText = recipe.title
                cell.descriptionText = recipe.cuisine
                cell.commonInit()
            }
            .disposed(by: disposeBag)
        
        recipesTable.rx
            .itemDeleted
            .subscribe { event in
                self.viewModel.deleteRecipeWith(index: event.element!.row)
            }
            .disposed(by: disposeBag)
        
        recipesTable.rx.modelSelected(Recipe.self)
            .subscribe{
                recipe in
                let recipeView = self.storyboard?.instantiateViewController(withIdentifier: "recipe") as! RecipeViewController
                recipeView.viewModel = RecipeViewViewModel(savedRecipeId: recipe.element!.id)
                self.navigationController?.pushViewController(recipeView, animated: true)
        }
    .disposed(by: disposeBag)
    
                
        
        
    }
}



