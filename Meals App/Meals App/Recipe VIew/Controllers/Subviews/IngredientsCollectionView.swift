
import UIKit

class IngredientsCollectionView: UICollectionView {
    
    let IngredientCellID = "IngredientsCollectionViewCell"
    var ingredients : [Ingredient]!
    var savedIngredients : [SavedIngredient]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        self.register(UINib(nibName: IngredientCellID , bundle: nil), forCellWithReuseIdentifier: IngredientCellID)
        self.reloadData()
       }
    
    func commonInit(ingredients: [Ingredient], savedIngredients: [SavedIngredient]?) {
        self.ingredients = ingredients
        self.savedIngredients = savedIngredients
        self.reloadData()
    }
}

extension IngredientsCollectionView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count == 0 ? (savedIngredients?.count ?? 0) : ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: IngredientCellID, for: indexPath) as! IngredientsCollectionViewCell
        if ingredients.count != 0 {
            cell.name = ingredients[indexPath.row].name
            cell.amountInMetric = "\(Int(ingredients[indexPath.row].measures.metric.amount)) \(ingredients[indexPath.row].measures.metric.unitShort)"
            cell.imageURL = ingredients[indexPath.row].imageURL()
        }else{
            cell.name = savedIngredients![indexPath.row].name
            cell.amountInMetric = savedIngredients![indexPath.row].amount
            cell.imageData = savedIngredients![indexPath.row].image
        }
        cell.commonInit()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 150)
    }
}
