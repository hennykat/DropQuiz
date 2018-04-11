import UIKit

extension UITextField {
    
    func underline(colour: CGColor, thickness: CGFloat) {
        
        let underlineLayer = CALayer()
        underlineLayer.frame = CGRect(x: 0, y: self.frame.size.height - thickness, width:  self.frame.size.width, height: self.frame.size.height)
        underlineLayer.borderWidth = thickness
        underlineLayer.borderColor = colour
        
        self.layer.addSublayer(underlineLayer)
        self.layer.masksToBounds = true
    }
}
