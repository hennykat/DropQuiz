import UIKit

protocol IconPickerDelegate {
    func iconPicked(iconName: String)
}

class IconPickerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    public var delegate: IconPickerDelegate?
    private let iconNameList = [ImageName.Star, ImageName.Heart, ImageName.World, ImageName.Art, ImageName.Animal, ImageName.Food, ImageName.Money]
    
    // MARK: IBOutlet

    @IBOutlet weak var iconCollectionView: UICollectionView!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconCollectionView.register(UINib(nibName: ViewIdentifier.IconImageCell, bundle: nil), forCellWithReuseIdentifier: ViewIdentifier.IconImageCell)
        iconCollectionView.delegate = self
        iconCollectionView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.iconPicked(iconName: getIconName(indexPath))
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewIdentifier.IconImageCell, for: indexPath) as! IconImageCell
        cell.iconImageView.image = UIImage(named: getIconName(indexPath))
        
        return cell
    }
    
    // MARK: Collection Util
    
    func getIconName(_ indexPath: IndexPath) -> String {
        
        let index = indexPath.row
        if index < 0 || index >= iconNameList.count {
            print("failed to get icon name, invalid index")
            return ImageName.Default
        }
        
        return iconNameList[index]
    }
}
