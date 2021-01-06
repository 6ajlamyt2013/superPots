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
    
    var yOffset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordSecureField.delegate = self
        
        //скрываем клавиатуру по тапу на VC
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
        
        mainStackView.addArangedSubviews(
            logoView,
            subStackView
        )
        
        fieldsStackView.addArangedSubviews(
            emailTextField,
            passwordSecureField
        )
        
        subStackView.addArangedSubviews(
            fieldsStackView,
            enterButton
        )
        
        logoView.snp.makeConstraints { (make) in
            make.top.equalTo(mainStackView).offset(30)
            make.height.equalTo(view).multipliedBy(0.55)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
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
        #if DEBUG
            print("fake session")
            NetworkLayer.authClient()
        #else
            NetworkLayer.authClient(email: emailTextField.text ?? "", password: passwordSecureField.text ?? "", method: "auth")
        #endif
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
