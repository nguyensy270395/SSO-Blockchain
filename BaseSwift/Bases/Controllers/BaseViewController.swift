import UIKit
import RxSwift
import RxCocoa

protocol BaseViewControllerProtocol: AnyObject {
    associatedtype ViewModelType: BaseViewModelProtocol
    var viewModel: ViewModelType! { get set }
    func setupViews()
    func bindingViewModels()
    func setupRx()
}

extension BaseViewControllerProtocol where Self: UIViewController {
    static func instantiate<ViewModelType> (withViewModel viewModel: ViewModelType) -> Self where ViewModelType == Self.ViewModelType {
        let viewController = Self.init()
        viewController.viewModel = viewModel
        return viewController
    }
}

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var disposeBag = DisposeBag()
    var interactivePopGestureRecognizer = true
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return interactivePopGestureRecognizer
        }
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
#if DEBUG
        print("Deinit:\(self.className)")
#endif
    }
}

class BaseTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    var disposeBag = DisposeBag()
    var interactivePopGestureRecognizer = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return interactivePopGestureRecognizer
        }
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
#if DEBUG
        print("Deinit:\(self.className)")
#endif
    }
}
