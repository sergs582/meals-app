

import UIKit

class SearchResultsController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    

    let CellReuseIdentifier = "searchCell"
    
    weak var resultsDelegate : RecipeResultsDelegate?
    weak var queryDelegate: QueryDelegate?
    let viewModel = SearchResultsViewViewModel()
    var timer : Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: CellReuseIdentifier)
        self.definesPresentationContext = true
        viewModel.searchQuery.bind { [unowned self] (query) in
            self.viewModel.fetchResults(query: query, number: 10)
        }
        
        viewModel.recipes.bind { (results) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }

    
    func updateSearchResults(for searchController: UISearchController) {
        timer?.invalidate()
        
        let currentText = searchController.searchBar.text ?? ""
        if currentText.count >= 3 {

        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
            self.viewModel.searchQuery.value = searchController.searchBar.text
            self.queryDelegate?.addToRecent(query: currentText)
            })
        }
        if searchController.searchBar.text == "" {
            viewModel.recipes.value = [SearchRecipe]()
        }

    }
    
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.recipesCount()
    }
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height{
            if !viewModel.fetchingMore {
            beginBatchFetched()
            }
        }
    }
    
    func beginBatchFetched() {
        viewModel.fetchingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            self.viewModel.fetchResults(query: self.viewModel.searchQuery.value , number: 30)
            self.viewModel.fetchingMore = false
        })
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier, for: indexPath) as! RecipeCell
        cell.titleText = viewModel.recipeTitle(at: indexPath.row)
        cell.imageURL = viewModel.imageURL(at: indexPath.row)
        cell.descriptionText = viewModel.recipeCuisine(at: indexPath.row)
        cell.commonInit()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = viewModel.recipe(at: indexPath.row)
        resultsDelegate?.didSelectResult(recipe: recipe )
 
    }

}
