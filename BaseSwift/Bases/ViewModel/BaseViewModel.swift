import UIKit
import RxSwift

//MARK: - BaseViewModelProtocol
protocol BaseViewModelProtocol: AnyObject {
    
    associatedtype Input
    associatedtype Output
    
    func transfrom(from input: Input) -> Output
}

//MARK: - BaseViewModel
class BaseViewModel: NSObject {
    var disposeBag = DisposeBag()
    
    override init() {
        super.init()
    }
    
    private let _lock = NSRecursiveLock()
    
    func trackActivityOfObservable<Source: ObservableConvertibleType>(_ source: Source) -> Observable<Source.Element> {
        return Observable.using({ () -> ActivityToken<Source.Element> in
            self.increment()
            return ActivityToken(source: source.asObservable(), disposeAction: self.decrement)
        }) { t in
            return t.asObservable()
        }
    }
    
    private func increment() {
        _lock.lock()
        UIApplication.shared.showProgress()
        _lock.unlock()
    }
    
    private func decrement() {
        _lock.lock()
        UIApplication.shared.hideProgress()
        _lock.unlock()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
#if DEBUG
        print("Deinit:\(self.className)")
#endif
    }
}

extension ObservableConvertibleType {
    func trackActivity(_ viewModel: BaseViewModel?) -> Observable<Element> {
        guard let viewModel = viewModel else { return asObservable()  }
        return viewModel.trackActivityOfObservable(self)
    }
}

struct ActivityToken<E> : ObservableConvertibleType, Disposable {
    private let _source: Observable<E>
    private let _dispose: Cancelable
    
    init(source: Observable<E>, disposeAction: @escaping () -> Void) {
        _source = source
        _dispose = Disposables.create(with: disposeAction)
    }
    
    func dispose() {
        _dispose.dispose()
    }
    
    func asObservable() -> Observable<E> {
        _source
    }
}

extension UIApplication {
    func showProgress() {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.activityIndicatorView.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    func hideProgress() {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.activityIndicatorView.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}
