import UIKit

extension UICollectionViewCell {
    static var nib:UINib {
        get{
           return UINib.init(nibName: self.className, bundle: nil)
        }
    }
    static var reuseIdentifier:String{
        get{
            return self.className
        }
    }
}
extension UITableViewCell {
    static var nib: UINib {
        get {
            return UINib.init(nibName: self.className, bundle: nil)
        }
    }
    static var reuseIdentifier: String {
        get {
            return self.className
        }
    }
  func separator(hide: Bool) {
    separatorInset.left = hide ? bounds.size.width : 0
  }
}
