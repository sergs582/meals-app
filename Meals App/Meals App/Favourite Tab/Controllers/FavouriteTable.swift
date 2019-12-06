

import UIKit

class FavouriteTable: UITableView, UITableViewDataSource, UITableViewDelegate {

//    var imageNames : [String]?
//    var titles : [String]?
//    var descriptions : [String]?
    
    //weak var resultsDelegate : RecipeResultsDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override class func awakeFromNib() {
           super.awakeFromNib()
    }
    
    func commonInit(){
        self.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "FavouriteCell")
        self.delegate = self
        self.dataSource = self
      }
    
    func updateContent( _ imageNamesArray : [String], _ titlesArray : [String], _ descriptionsArray: [String] ){
//        self.imageNames = imageNamesArray
//        self.titles = titlesArray
//        self.descriptions = descriptionsArray
        reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //resultsDelegate?.didSelectResult(cell: tableView.cellForRow(at: indexPath)!)
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! RecipeCell
        cell.commonInit()
        return cell
      }
}
