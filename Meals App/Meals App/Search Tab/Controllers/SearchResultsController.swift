

import UIKit
import RxSwift
import RxCocoa

class SearchResultsController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {

    let cellReuseIdentifier = "searchCell"
    
    weak var resultsDelegate : RecipeResultsDelegate?
    weak var queryDelegate: QueryDelegate?
    var viewModel : SearchResultsViewViewModel!
    var timer : Timer?
    let disposeBag = DisposeBag()
    weak var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchResultsViewViewModel()
        self.tableView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.definesPresentationContext = true
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.rowHeight = 80
        setupBinding()
    }

    func setupBinding() {
        let recipes = searchController?.searchBar.rx.text.orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest{
                query -> Observable<[SearchRecipe]> in
                if query.count <= 3 {
                    return .just([])
                }
                return self.viewModel.fetchResults(query: query, number: 20)
            }
            .catchErrorJustReturn([])
            .observeOn(MainScheduler.instance)
            
        recipes!
            .bind(to: tableView.rx.items(cellIdentifier: cellReuseIdentifier, cellType: RecipeCell.self)) {  row, recipe, cell in
                cell.titleText = recipe.title
                cell.imageURL = recipe.imageURL
                cell.descriptionText = "International"
                cell.commonInit()
            }
            .disposed(by: disposeBag)
               
        tableView.rx.modelSelected(SearchRecipe.self)
            .subscribe { recipe in
            self.resultsDelegate?.didSelectResult(recipe: recipe.element!.toRecipe())
            }
            .disposed(by: disposeBag)
    }
    
    func updateSearchResults(for searchController: UISearchController) {

    }
}
