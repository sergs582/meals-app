

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, QueryDelegate {
    
    
    
    @IBOutlet weak var recentSearchTable: UITableView!
    var viewModel = SearchViewViewModel()
    

    let HeaderReuseIdentifier = "RecentSearchHeader"
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomizeNavBar()
      
        setupTable(recentSearchTable)
        viewModel.recentSearch.bind { [unowned self] (recent) in
            self.recentSearchTable.isHidden = false
            if recent.count == 0{
                self.recentSearchTable.isHidden = true
            }

            DispatchQueue.main.async {
                self.recentSearchTable.reloadData()
            }
            

        }
        
        
        
    }


   func CustomizeNavBar(){
            let searchStoryboard : UIStoryboard? = UIStoryboard(name: "SearchResults", bundle: nil)
            let resultsView = searchStoryboard?.instantiateViewController(withIdentifier: "searchResultsTable") as! SearchResultsController
            resultsView.resultsDelegate = self
            resultsView.queryDelegate = self
            let search = UISearchController(searchResultsController: resultsView)
            search.searchResultsUpdater = (resultsView as UISearchResultsUpdating)
   
            navigationItem.searchController = search
    
    }
    
    func addToRecent(query: String) {
        viewModel.updateRecent(newQuery: query)
    
    }
    
    func setupTable(_ table : UITableView){
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: HeaderReuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderReuseIdentifier)
    }
}

extension SearchViewController :  UITableViewDataSource, UITableViewDelegate{
    
    // MARK: Setup TableView Cells
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.searchController?.searchBar.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
        navigationItem.searchController?.isActive = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = viewModel.recentSearch.value[indexPath.row]
        cell.textLabel?.textColor = .systemGreen
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentSearch.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    // MARK: Setup TableView Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.recentSearchTable.dequeueReusableHeaderFooterView(withIdentifier: HeaderReuseIdentifier) as! RecentSearchHeader
        header.recentDelegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension SearchViewController : RecentDelegate, RecipeResultsDelegate {
 
    
    func clearRecent() {
        viewModel.recentSearch.value = [String]()
        viewModel.updateUD()
    }
    
    func didSelectResult(recipe: Recipe) {
           let view = storyboard?.instantiateViewController(withIdentifier: "recipe") as! RecipeViewController
        view.viewModel = RecipeViewViewModel(withRecipe: recipe)
           navigationController?.pushViewController(view, animated: true)
    }
    
}
 
