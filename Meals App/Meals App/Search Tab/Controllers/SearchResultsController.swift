

import UIKit

class SearchResultsController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    

    let CellReuseIdentifier = "searchCell"
    
    weak var resultsDelegate : RecipeResultsDelegate?
    
    let viewModel = SearchResultsViewViewModel()
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: CellReuseIdentifier)
        
        
        viewModel.searchQuery.bind { [unowned self] (query) in
            self.viewModel.fetchResults(query: query)
            
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier, for: indexPath) as! RecipeCell
        cell.titleText = viewModel.recipeTitle(at: indexPath.row)
        cell.imageURL = viewModel.imageURL(at: indexPath.row)
        cell.descriptionText = viewModel.recipeCuisine(at: indexPath.row)
        cell.commonInit()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultsDelegate?.didSelectResult(cell: tableView.cellForRow(at: indexPath)!)
    }

}
