import Foundation
import UIKit

class IconImageCell: UICollectionViewCell {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: UICollectionViewCell
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = self.frame.width / 2
    }
}
