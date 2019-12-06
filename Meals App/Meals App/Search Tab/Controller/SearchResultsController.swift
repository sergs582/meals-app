

import UIKit

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
    

    let CellReuseIdentifier = "searchCell"
    
    weak var resultsDelegate : RecipeResultsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: CellReuseIdentifier)
    }

    func updateSearchResults(for searchController: UISearchController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 80
       }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier, for: indexPath) as! RecipeCell

        cell.commonInit()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultsDelegate?.didSelectResult(cell: tableView.cellForRow(at: indexPath)!)
    }

}
