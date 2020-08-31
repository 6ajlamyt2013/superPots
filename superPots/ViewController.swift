import SnapKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.keyboardDismissMode = .interactive
        view.showsVerticalScrollIndicator = false
        return view
    }()
    lazy var logoView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "jungle.png")
        img.clipsToBounds = true
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        img.isHighlighted = true
        return img
    }()
    let emailTextField: UITextField = {
        let email = UITextField()
        email.placeholder = "Введите ваш email"
        email.borderStyle = UITextField.BorderStyle.none
        email.keyboardType = UIKeyboardType.emailAddress
        email.returnKeyType = UIReturnKeyType.next
        return email
    }()
    let passwordSecureField: UITextField = {
        let pwd = UITextField()
        pwd.placeholder = "Введите ваш пароль"
        pwd.isSecureTextEntry = true
        pwd.borderStyle = UITextField.BorderStyle.none
        pwd.keyboardType = UIKeyboardType.emailAddress
        pwd.returnKeyType = UIReturnKeyType.done
        return pwd
    }()
    let enterButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(red: 49, green: 159, blue: 94)
        btn.setTitle("Войти", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.opacity = 0.7
        
        return btn
    }()
    let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    let fieldsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 40
        return stack
    }()
    let subStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 60
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 60)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordSecureField.delegate = self
        
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self.view ,
                action: #selector(UIView.endEditing)
            )
        )
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        scrollView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        fieldsStackView.addArangedSubviews(
            emailTextField,
            passwordSecureField
        )
        subStackView.addArangedSubviews(
            fieldsStackView,
            enterButton
        )
        mainStackView.addArangedSubviews(
            logoView,
            subStackView
        )
        
        logoView.snp.makeConstraints { (make) in
            make.height.equalTo(view).multipliedBy(0.6)
            make.width.equalTo(view)
            
        }
        enterButton.addTarget(
            self,
            action: #selector(didTapOnEnterButton),
            for: .touchUpInside
        )
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    override func viewDidAppear(_ animated: Bool = true) {
        super.viewDidAppear(animated)
        enterButton.layer.cornerRadius = enterButton.bounds.height / 2
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame,
                                                from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: (keyboardViewEndFrame.height - view.safeAreaInsets.bottom) + 10,
                right: 0
            )
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    @objc
    private func didTapOnEnterButton() {
        let secondViewController = HoumViewController()
        secondViewController.modalPresentationStyle = .fullScreen
        present(secondViewController, animated: true, completion: nil)
        // Заглушка
        NetworkLayer.authClient()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordSecureField.becomeFirstResponder()
        } else if textField == passwordSecureField {
            passwordSecureField.resignFirstResponder()
        }
        return true
    }
}
extension UIView {
    var safeArea : ConstraintLayoutGuideDSL {
        return safeAreaLayoutGuide.snp
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: 1.0
        )
    }
}
extension UIStackView {
    func addArangedSubviews(_ views: UIView...) {
        views.forEach(addArrangedSubview)
    }
}
