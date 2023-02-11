import UIKit
import RxSwift

class BaseSearchBar: UISearchBar {
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
        self.frame = CGRect(x: 0, y: 0, width: 200, height: 90)
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "フリーワード検索", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
            textfield.clipsToBounds = true
            textfield.layer.cornerRadius = 17
            
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 11).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 13).isActive = true
            imageView.contentMode = .scaleAspectFit
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            let paddingView = UIView()
            paddingView.translatesAutoresizingMaskIntoConstraints = false
            paddingView.widthAnchor.constraint(equalToConstant: 10).isActive = true
            paddingView.heightAnchor.constraint(equalToConstant: 10).isActive = true
            let paddingViewRight = UIView()
            paddingViewRight.translatesAutoresizingMaskIntoConstraints = false
            paddingViewRight.widthAnchor.constraint(equalToConstant: 4).isActive = true
            paddingViewRight.heightAnchor.constraint(equalToConstant: 10).isActive = true
            stackView.addArrangedSubview(paddingView)
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(paddingViewRight)
            textfield.leftView = stackView
            
            
        }
        self.barTintColor = UIColor.white
        self.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.updateHeight(height: 50)
    }
    
    
}
extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }
}
extension UISearchBar {
    func updateHeight(height: CGFloat, radius: CGFloat = 25) {
        let image: UIImage? = UIImage.imageWithColor(color: UIColor.clear, size: CGSize(width: 1, height: height))
        setSearchFieldBackgroundImage(image, for: .normal)
        for subview in self.subviews {
            for subSubViews in subview.subviews {
                if #available(iOS 13.0, *) {
                    for child in subSubViews.subviews {
                        if let textField = child as? UISearchTextField {
                            textField.layer.cornerRadius = radius
                            textField.clipsToBounds = true
                        }
                    }
                    continue
                }
                if let textField = subSubViews as? UITextField {
                    textField.layer.cornerRadius = radius
                    textField.clipsToBounds = true
                }
            }
        }
    }
}
extension UIImage {
    static func imageWithColor(color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
}
