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
    var isShowBackButton = false
    var isShowNavigationBar = false
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(
            image: R.image.iconBack()?.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(backButtonTouchUpInside)
        )
        newBackButton.imageInsets = .init(top: 0, left: -12, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = newBackButton
        self.navigationItem.hidesBackButton = !isShowBackButton
        self.navigationController?.isNavigationBarHidden = !isShowNavigationBar
    }

@objc
private func backButtonTouchUpInside() {
    self.navigationController?.popViewController(animated: true)
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
    var isShowBackButton = false
    var isShowNavigationBar = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = !isShowBackButton
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        overrideUserInterfaceStyle = .light
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = !isShowNavigationBar
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
