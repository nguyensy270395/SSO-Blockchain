//
//  UITableView+Extension.swift
//  QikNote
//
//  Created by daovu on 03/03/2021.
//

import Foundation
import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: cellType.className, for: indexPath) as? T {
            return cell
        } else {
            fatalError("Couldn't dequeueReusableCell \(cellType.className)")
        }
    }

    func registerNib<T: UITableViewCell>(_ cellType: T.Type) {
        let nib = UINib(nibName: cellType.className, bundle: nil)
        register(nib, forCellReuseIdentifier: cellType.className)
    }

    func registerHeaderFooterNib<T: UITableViewHeaderFooterView>(_ aClass: T.Type) {
        let className = String(describing: aClass)
        let nibFile = UINib(nibName: className, bundle: nil)
        register(nibFile, forHeaderFooterViewReuseIdentifier: className)
    }
}

@IBDesignable extension UITableViewCell {
    @IBInspectable var selectedColor: UIColor? {
        get {
            return selectedBackgroundView?.backgroundColor
        }
        
        set {
            if let color = newValue {
                selectedBackgroundView = UIView()
                selectedBackgroundView!.backgroundColor = color
            } else {
                selectedBackgroundView = nil
            }
        }
    }
}

extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.className)
    }
    
    func registerNib<T: UICollectionViewCell>(_ cellType: T.Type) {
        let nib = UINib(nibName: cellType.className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: cellType.className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withReuseIdentifier: cellType.className, for: indexPath) as? T {
            return cell
        } else {
            fatalError("Couldn't dequeueReusableCell \(cellType.className)")
        }
    }
}

extension NSDiffableDataSourceSnapshot  {
    subscript(_ index: Int) -> ItemIdentifierType {
        return itemIdentifiers[index]
    }
}

public extension UITableView {
    /// An utility method to register a cell class by its class name
    /// Caution: The cellClass should not be optional as the `String(describing: cellClass)` produce different string on optional/non-optional types
    /// - Parameter cellClass: cell class
    func register(_ cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }

    func dequeueReusableCell<CellClass>(withCellType cellClass: CellClass.Type, for indexPath: IndexPath) -> CellClass {
        // Force casting purposely in order to know something wrong straight away
        return dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as! CellClass
    }

    /// A utility method to register a table header / footer class by its class name
    /// - Warning: The headerFooterClass should not be optional as the `String(describing: cellClass)`
    /// produce different string on optional/non-optional types
    /// - Parameter headerFooterClass: table view header or footer class
    func registerHeaderFooter(_ headerFooterClass: AnyClass) {
        register(headerFooterClass, forHeaderFooterViewReuseIdentifier: String(describing: headerFooterClass))
    }

    func dequeueHeaderFooter<HeaderFooterClass>(withType classType: HeaderFooterClass.Type) -> HeaderFooterClass {
        dequeueReusableHeaderFooterView(withIdentifier: String(describing: classType)) as! HeaderFooterClass
    }
}
