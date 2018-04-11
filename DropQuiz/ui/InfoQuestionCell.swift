import Foundation
import UIKit

class InfoQuestionCell: UICollectionViewCell {
    
    // MARK: IBOutlet
    @IBOutlet weak var questionLabel: UILabel!
    
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
        updateBackground()
    }
    
    func updateBackground() {
        
        for subview in self.subviews {
            if subview is GradientView {
                subview.removeFromSuperview()
            }
        }
        
        guard let primaryColour = UIColor(named: ColourName.Primary)?.cgColor else {
            return
        }
        
        guard let accentColour = UIColor(named: ColourName.Accent)?.cgColor else {
            return
        }
        
        let gradientView = GradientView(frame: self.frame, colours: [accentColour, primaryColour, accentColour], locations: [0.0, 0.5, 1.0])
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.insertSubview(gradientView, at: 0)
    }
}
