
import UIKit

class ActivityIndicatorView: UIView {
    @IBOutlet weak private var backgroundActivityView: UIView!
    @IBOutlet weak private var activityTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundActivityView.layer.cornerRadius = 5.0
    }

    class func showActivity() -> ActivityIndicatorView {
        return ActivityIndicatorView.showActivityWith(title: "")
    }
    
    class func showActivityWith(title: String) -> ActivityIndicatorView {
        let view = Bundle.main.loadNibNamed(ActivityIndicatorView.className(), owner: self, options: nil)?.first as! ActivityIndicatorView
        view.activityTitleLabel.text = (title.isEmpty) ? "" : title
        
        view.alpha = 0.0
        view.frame = (UIApplication.shared.keyWindow?.frame)!
        view.layoutIfNeeded()
        UIApplication.shared.keyWindow?.addSubview(view)
        
        UIView.animate(withDuration: ActivityIndicatorView.activityDuration()) {
            view.alpha = 1.0
        }
        
        return view
    }
    
    class func hideActivity(activity: ActivityIndicatorView) {
        UIView.animate(withDuration: ActivityIndicatorView.activityDuration(), animations: {
            activity.alpha = 0.0
        }) { (isFinished) in
            
            if isFinished { activity.removeFromSuperview() }
            
        }
    }
    
    class func hideAllActivity() {
        for curActivity in (UIApplication.shared.keyWindow?.subviews)! {
            if curActivity.isKind(of: ActivityIndicatorView.self) {
                ActivityIndicatorView.hideActivity(activity: curActivity as! ActivityIndicatorView)
            }
        }
    }
    
    // MARK: Helpers
    
    private class func activityDuration() -> Double {
        return 0.3
    }
}
