import UIKit

class JCOTPComponentImplementation: NSObject, UITextFieldDelegate {
    weak var implementationDelegate: JCOTPComponentImplementationProtocol?

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < implementationDelegate?.digitsCount ?? 0 || string == ""
    }
}
