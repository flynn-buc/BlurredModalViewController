import UIKit

public class BlurredModalViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    private var blurView: UIVisualEffectView!
    private var vcToDisplay: UIViewController?
    public var style: UIBlurEffect.Style = .dark
    public var constraints: [NSLayoutConstraint]?
    public var delay: TimeInterval = 0
    public var duration: TimeInterval = 0.5
    public var options : UIView.AnimationOptions =  [.allowUserInteraction]
    private var hasDismissed = false
    private var shouldDismiss = true
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        let defaultConstraints = [blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
                                  blurView.widthAnchor.constraint(equalTo: view.widthAnchor)]
        
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate(constraints ?? defaultConstraints)
        self.view.alpha = 0
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        if let vcToDisplay = vcToDisplay{
            self.present(vcToDisplay, animated: true, completion: nil)
        }
        self.blur()
    }
    
    public func setViewControllerToDisplay(_ viewController: UIViewController){
        vcToDisplay = viewController
        vcToDisplay?.presentationController?.delegate = self
    }
    
    func blur(alpha: CGFloat = 1, dismiss: Bool = false, duration: TimeInterval? = nil, completion: ((Bool) ->Void)? = nil){
        let duration = duration ?? self.duration
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration, delay: self.delay, options: self.options, animations: {self.view.alpha = alpha}, completion: completion)
            if dismiss{
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    public func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        hasDismissed = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            if !self.hasDismissed{
                self.blur(duration: 0.2)
            }else{
                self.shouldDismiss = false
            }
        }
        blur(alpha: 0, dismiss: false) { (completed) in
            
        }
        return true;
    }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController){
        hasDismissed = true
        if shouldDismiss{
            dismiss(animated: true, completion: nil)
        }
    }
}
