

import UIKit
import RxSwift

class SearchViewController: UIViewController, UISearchBarDelegate, QueryDelegate {
    
    @IBOutlet weak var recentSearchTable: UITableView!
    var viewModel = SearchViewViewModel()

    let HeaderReuseIdentifier = "RecentSearchHeader"
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavBar()
        recentSearchTable.rx.setDelegate(self).disposed(by: disposeBag)
        recentSearchTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        recentSearchTable.register(UINib(nibName: HeaderReuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderReuseIdentifier)
        recentSearchTable.rx.modelSelected(String.self)
            .subscribe{ query in
                self.navigationItem.searchController?.searchBar.text =  query.element
                self.navigationItem.searchController?.isActive = true
            }
            .disposed(by: disposeBag)
        
        viewModel.recentSearch.subscribe { event in
            self.recentSearchTable.isHidden = false
            guard let queries = event.element else {
                self.recentSearchTable.isHidden = true
                return
            }
            if queries.isEmpty {
                self.recentSearchTable.isHidden = true
            }
        }
        .disposed(by: disposeBag)
        
        DispatchQueue.main.async {
            self.viewModel.recentSearch
                .bind(to: self.recentSearchTable.rx.items(cellIdentifier: "Cell")){
                row, recent, cell in
                cell.textLabel?.text = recent
                cell.textLabel?.textColor = .systemGreen
                cell.textLabel?.font = UIFont.systemFont(ofSize: 18)

            }
            .disposed(by: self.disposeBag)
        }
        
        navigationItem.searchController?.searchBar.rx.text
            .debounce(.seconds(3), scheduler: MainScheduler.instance)
            .subscribe(onNext: { query in
                guard let query = query else { return }
                if query.count >= 3 {
                    self.viewModel.updateRecentWith(newQuery: query)
                }
            })
            .disposed(by: disposeBag)
    }

   

   func customizeNavBar() {
        let searchStoryboard : UIStoryboard? = UIStoryboard(name: "SearchResults", bundle: nil)
        let resultsView = searchStoryboard?.instantiateViewController(withIdentifier: "searchResultsTable") as! SearchResultsController
        resultsView.resultsDelegate = self
        resultsView.queryDelegate = self
    
        let search = UISearchController(searchResultsController: resultsView)
        resultsView.searchController = search
        search.searchResultsUpdater = (resultsView as UISearchResultsUpdating)
        navigationItem.searchController = search
    
    }
    
    func addToRecent(query: String) {
    }
    
    func setupTable(_ table : UITableView) {
        table.dataSource = nil
        table.delegate = nil
        
    }
}

extension SearchViewController :  UITableViewDelegate {

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
        viewModel.clearRecent()
        recentSearchTable.isHidden = true
    }
    
    func didSelectResult(recipe: Recipe) {
        let view = storyboard?.instantiateViewController(withIdentifier: "recipe") as! RecipeViewController
        view.viewModel = RecipeViewViewModel(recipeID: recipe.id, dataManager: RecipeManager())
    
        navigationController?.pushViewController(view, animated: true)
    }
    
}
 
