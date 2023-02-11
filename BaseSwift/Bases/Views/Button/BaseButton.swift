import UIKit
import RxSwift
import RxCocoa
@IBDesignable
public class BaseButton: UIButton {
    var disposeBag = DisposeBag()
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        
    }
    public override var isSelected: Bool{
        didSet{
            if isSelected{
                self.alpha = 1
            }else{
                self.alpha = 0.4
            }
        }
        
    }
    
}
