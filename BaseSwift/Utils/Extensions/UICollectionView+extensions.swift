//
//  UICollectionView+extensions.swift
//  gurume_go_ios
//
//  Created by Nguyễn Thanh Sỹ on 08/07/2022.
//

import Foundation
import UIKit

extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() -> Int? {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
//            switch closestCellIndex {
//            case 0: return 3
//            case 1: return 4
//            case 5: return 2
//            case 6: return 3
//            case 7: return 4
//            case 8: return 2
//            default:
                return closestCellIndex
//            }
        }
        return nil
    }
}
