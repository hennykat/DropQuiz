import UIKit

class GradientView: UIView {
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    public init(frame: CGRect, colours: [CGColor], locations: [NSNumber]) {
        super.init(frame: frame)
        
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = colours
        gradientLayer.locations = locations
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = self.frame
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
