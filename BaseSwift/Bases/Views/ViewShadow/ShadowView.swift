import Foundation
import UIKit
import RxSwift
import RxCocoa
@IBDesignable
public class ShadowView: UIView {
    @IBInspectable public var shadowColor: UIColor = UIColor.black.withAlphaComponent(0.16)
    
    /// The offet of the shadow in the form (x, y)
    @IBInspectable public var shadowOffset: CGSize = CGSize(width: 0, height: 3)
    
    /// The blur of the shadown
    @IBInspectable public var shadowRadius: CGFloat = 6
    
    /// The opacity of the shadow applied to the view
    @IBInspectable public var shadowOpacity: Float = 1
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        update()
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        update()
    }
    
    func update(){
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }
}
