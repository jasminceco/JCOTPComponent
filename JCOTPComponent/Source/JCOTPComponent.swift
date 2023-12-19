

import UIKit

public class JCOTPComponent: UITextField {
    
    public var defaultCharacter = ""
    public var componentBackgroundColor: UIColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
    public var filledBackgroundColor: UIColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
    public var cornerRadius: CGFloat = 10
    public var defaultBorderColor: UIColor = .clear
    public var filledBorderColor: UIColor = .darkGray
    public var defaultBorderWidth: CGFloat = 0
    public var filledBorderWidth: CGFloat = 1
    public var componentTextColor: UIColor = .black
    public var fontSize: CGFloat = 14
    public var componentFont: UIFont = UIFont.systemFont(ofSize: 14)
    public weak var componentDelegate: JCOTPComponentDelegate?
    private var implementation = JCOTPComponentImplementation()
    private var isConfigured = false
    private var digits = [UILabel]()
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()
    
    public func configure(with digits: Int = 6) {
        guard isConfigured == false else { return }
        isConfigured.toggle()
        setupTextFiled()
        let digitsStackView = createDigitsStack(with: digits)
        addSubview(digitsStackView)
        addGestureRecognizer(tapRecognizer)
        NSLayoutConstraint.activate([
            digitsStackView.topAnchor.constraint(equalTo: topAnchor),
            digitsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            digitsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            digitsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func clearDigits() {
        text = nil
        digits.forEach {
            $0.text = defaultCharacter
            $0.layer.borderWidth = defaultBorderWidth
            $0.layer.borderColor = defaultBorderColor.cgColor
            $0.backgroundColor = componentBackgroundColor
        }
    }

    public func setDigits(_ text: String) {
        let characters = Array(text)
        for i in 0 ..< characters.count where digits.indices.contains(i) {
            digits[i].text = String(characters[i])
        }
    }
    
    func setupTextFiled() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        borderStyle = .none
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        addTarget(self, action: #selector(textEditingDidBegin), for: .editingDidBegin)
        delegate = implementation
        implementation.implementationDelegate = self
    }
    
    func createDigitsStack(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        for _ in 1 ... count {
            let label = digitsLabel
            stackView.addArrangedSubview(label)
            digits.append(label)
        }
        return stackView
    }
    
    var digitsLabel: UILabel {
        let label = UILabel()
        label.backgroundColor = componentBackgroundColor
        label.layer.cornerRadius = cornerRadius
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = componentTextColor
        label.font = label.font.withSize(fontSize)
        label.font = componentFont
        label.isUserInteractionEnabled = true
        label.layer.masksToBounds = true
        label.text = defaultCharacter
        return label
    }
    
    @objc
    func textEditingDidBegin() {
        guard let text = self.text, text.count <= digits.count else { return }
        componentDelegate?.onBeginEnter(code: text)
    }
    
    @objc
    func textDidChange() {
        guard let text = self.text, text.count <= digits.count else { return }
        componentDelegate?.onEnter(code: text)
        for labelIndex in 0 ..< digits.count {
            let currentLabel = digits[labelIndex]
            if labelIndex < text.count {
                let index = text.index(text.startIndex, offsetBy: labelIndex)
                currentLabel.text = isSecureTextEntry ? "✱" : String(text[index])
                currentLabel.layer.borderWidth = filledBorderWidth
                currentLabel.layer.borderColor = filledBorderColor.cgColor
                currentLabel.backgroundColor = filledBackgroundColor
            } else {
                currentLabel.text = defaultCharacter
                currentLabel.layer.borderWidth = defaultBorderWidth
                currentLabel.layer.borderColor = defaultBorderColor.cgColor
                currentLabel.backgroundColor = componentBackgroundColor
            }
        }
        if text.count == digits.count {
            componentDelegate?.didFinishEnter(code: text) {
                if !$0 {
                    digits.forEach { $0.shake() }
                }
            }
        }
    }
}

extension JCOTPComponent: JCOTPComponentImplementationProtocol {
    var digitsCount: Int {
        digits.count
    }
}
