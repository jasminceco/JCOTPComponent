import UIKit

extension UIView {
 
    public func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunctions = [
            CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut),
            CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        ]
        animation.values = [-8.0, 8.0, -6.0, 6.0, -4.0, 4.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
