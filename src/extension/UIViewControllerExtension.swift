
import UIKit

extension UIViewController {
    class func initFromNib() -> UIViewController {
        return self.init(nibName: self.className(), bundle: nil)
    }
    
    public func alertShowMessage(_ message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
        }))
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            if let topController = topController as? UINavigationController {
                topController.topViewController!.present(alert, animated: true, completion: nil)
            } else {
                topController.present(alert, animated: true, completion: nil)
            }
        }
    }
}
