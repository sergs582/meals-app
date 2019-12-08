
import UIKit

class IngredientsCollectionView: UICollectionView {
    
    let IngredientCellID = "IngredientsCollectionViewCell"
    var ingredients : [Ingredient]!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        self.register(UINib(nibName: IngredientCellID , bundle: nil), forCellWithReuseIdentifier: IngredientCellID)
        self.reloadData()
       }
    
    func commonInit(ingredients: [Ingredient]){
        self.ingredients = ingredients
    }
}

extension IngredientsCollectionView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: IngredientCellID, for: indexPath) as! IngredientsCollectionViewCell
        cell.name = ingredients[indexPath.row].name
        cell.amountInMetric = ingredients[indexPath.row].amountInMetric
        cell.amountInUS = ingredients[indexPath.row].amountInUS
        cell.commonInit()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 150)
    }
}
