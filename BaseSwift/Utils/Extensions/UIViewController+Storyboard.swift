//
//  UIViewController+Storyboard.swift
//  ar-sample-ios
//
//  Created by daovu on 04/05/2022.
//

import Foundation
import UIKit

protocol StoryBoardIdentifiable: class {
    static var storyboard: UIStoryboard { get }
}

extension StoryBoardIdentifiable {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
    }
}

extension StoryBoardIdentifiable where Self: UIViewController {
    
    static func instantiate(creator: @escaping (NSCoder) -> Self?) -> Self {
        return storyboard.instantiateViewController(identifier: storyboardIdentifier, creator: creator)
    }
}

extension UIViewController: StoryBoardIdentifiable {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
