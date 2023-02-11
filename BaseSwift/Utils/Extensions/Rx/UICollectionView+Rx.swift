import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: UICollectionView {
    var isAnimating: Binder<RequestType> {
        Binder(self.base) { base, isAnimating in
            switch isAnimating{
            case .load:
                base.activityIndicatorView.startAnimating()
                break
            case .refresh:
                break
            case .loadMore:
                break
            case .completion:
                base.activityIndicatorView.stopAnimating()
                base.refreshControl?.endRefreshing()
                break
            }
            
        }
    }
}
