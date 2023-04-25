import Foundation
import UIKit
import Photos
import LinkPresentation
extension UIViewController{
    func setBackButton() {
        let button = UIButton(frame: CGRect.init(x: -12, y: 0, width: 44, height: 44))
        button.setImage(UIImage(), for: .normal)
        button.setTitle(nil, for: .normal)
        button.addTarget(self, action:  #selector(goBack), for: .touchUpInside)
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 44, height: 44)))
        view.clipsToBounds = false
        view.addSubview(button)
        let item = UIBarButtonItem.init(customView: view)
        self.navigationItem.leftBarButtonItem = item
    }
    func openURLInBrowser(urlString:String?){
        guard let urlString = urlString,let url = URL.init(string: urlString),UIApplication.shared.canOpenURL(url)else{
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func goBack(){
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            self.navigationController?.popViewController(animated: true)
        }else if self.presentingViewController != nil{
            self.dismiss(animated: true, completion: nil)
        } else if ((self.navigationController?.presentingViewController) != nil){
            self.navigationController?.dismiss(animated: true, completion: nil)
        } else{
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    
    func makePhoneCall(phone:String){
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController{
    func share(text:String,link:URL?,viewBackground:UIView?){
        
        let paths = Bundle.main.paths(forResourcesOfType: "png", inDirectory: nil)
        let linkMetaData = LPLinkMetadata()
        linkMetaData.imageProvider = NSItemProvider(contentsOf: URL(fileURLWithPath: paths.first ?? ""))
        linkMetaData.originalURL = link
        linkMetaData.title = text
        let metadataItemSource = LinkPresentationItemSource(metaData: linkMetaData)
        let activity = UIActivityViewController(activityItems: [metadataItemSource], applicationActivities: [])
        present(activity, animated: true)
    }
    
    func requestAccessLibrary(callback: (()->())? = nil) {
        if PHPhotoLibrary.authorizationStatus() == .authorized{
            callback?()
        } else {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
                switch status {
                case .authorized,.limited:
                    DispatchQueue.main.async {
                        callback?()
                    }
                default:
                    DispatchQueue.main.async {
                        self.showNeedAccessMessage()
                    }
                }
            })
        }
    }
    
    func showNeedAccessMessage() {
        let alert = UIAlertController(title: "Image picker", message: "App need get access to photos", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction) -> Void in
            guard let url = URL(string: UIApplication.openSettingsURLString) else {return}
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }))
        
        present(alert, animated: false, completion: nil)
    }
}

class LinkPresentationItemSource: NSObject, UIActivityItemSource {
    var linkMetaData = LPLinkMetadata()
    
    //Prepare data to share
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        return linkMetaData
    }
    
    //Placeholder for real data, we don't care in this example so just return a simple string
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "Placeholder"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return linkMetaData.originalURL
    }
    
    init(metaData: LPLinkMetadata) {
        self.linkMetaData = metaData
    }
}
