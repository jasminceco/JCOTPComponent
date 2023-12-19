import UIKit
import JCOTPComponent

class ViewController: UIViewController {

    lazy var otpComponent: JCOTPComponent  = {
        let tf = JCOTPComponent()
        tf.componentDelegate = self
        tf.fontSize = 16
        tf.filledBackgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        tf.componentTextColor = .white
        tf.filledBorderWidth = 0
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.configure()
        return tf
    }()
    
    private let staticCode = "123456"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(otpComponent)
        NSLayoutConstraint.activate([
            otpComponent.heightAnchor.constraint(equalToConstant: 50),
            otpComponent.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            otpComponent.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            otpComponent.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
        ])
    }

    private func displayPopup(with title: String, message: String, actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else { return }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
}

extension ViewController: JCOTPComponentDelegate {
    func didFinishEnter(code: String, completion: (Bool) -> Void) {
        let doneAction = UIAlertAction(title: "Done", style: .default)
        let message = staticCode == code ? "Success" : "Failure"
        displayPopup(with: "Verify Result", message: message, actions: [doneAction])
        completion(staticCode == code)
    }
    
    func onEnter(code: String) {
        print(#function, code)
    }
    
    func onBeginEnter(code: String) {
        print(#function, code)
    }
}

