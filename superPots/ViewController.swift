import SnapKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let subview: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .red
        return view
    }()
    
    let contentView: UIView  = {
        let contentView = UIView()
        return contentView
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
        btn.layer.cornerRadius = 25
        btn.backgroundColor = UIColor(red: 49, green: 159, blue: 94)
        btn.setTitle("Войти", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.opacity = 0.7
        return btn
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view , action: #selector(UIView.endEditing))
        
        let testStek = UIStackView()
        testStek.alignment = .center
        testStek.addArrangedSubview(logoView)
        testStek.addArrangedSubview(emailTextField)
        testStek.addArrangedSubview(logoView)
        
        view.addGestureRecognizer(tap)
        view.addSubview(subview)
        self.subview.addSubview(contentView)
        self.subview.addSubview(logoView)
        self.subview.addSubview(emailTextField)
        self.subview.addSubview(passwordSecureField)
        self.subview.addSubview(enterButton)
        
        
        emailTextField.delegate = self
        passwordSecureField.delegate = self
        
        subview.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        logoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(60)
            make.height.equalTo(view).multipliedBy(0.6)
            make.trailing.leading.equalTo(view)
        }
        
        emailTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(logoView.snp.bottom).offset(0)
            make.left.equalTo(subview.snp.left).inset(60)
            make.leading.trailing.equalToSuperview()
        }
        
        passwordSecureField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(emailTextField.snp.bottom).offset(40)
            make.left.equalTo(subview.snp.left).inset(60)
            make.leading.trailing.equalToSuperview()
        }
        
        enterButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(passwordSecureField.snp.bottom).offset(60)
            make.left.right.equalTo(view).inset(60)
            make.height.equalTo(55)
        }
        
        enterButton.addTarget(self, action: #selector(didTapOnEnterButton), for: .touchUpInside)
    }
    
    @objc
    func didTapOnEnterButton() {
        let secondViewController:HoumViewController = HoumViewController()
        self.present(secondViewController, animated: true, completion: nil)
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
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
