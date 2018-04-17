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
        
        if let imageName = UIUtil.getListItem(at: indexPath, iconNameList, defaultItem: ImageName.Default) {
            delegate?.iconPicked(iconName: imageName)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewIdentifier.IconImageCell, for: indexPath) as! IconImageCell
        
        if let imageName = UIUtil.getListItem(at: indexPath, iconNameList, defaultItem: ImageName.Default) {
            cell.iconImageView.image = UIImage(named: imageName)
        }

        return cell
    }
}
