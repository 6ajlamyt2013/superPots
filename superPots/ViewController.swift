import SnapKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let subview: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    lazy var logoView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "jungle.png")
        img.backgroundColor = .red
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
        btn.layer.cornerRadius = 33
        btn.backgroundColor = UIColor(red: 49, green: 159, blue: 94)
        btn.setTitle("Войти", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.opacity = 0.7
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(subview)
        self.view.addSubview(logoView)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordSecureField)
        self.view.addSubview(enterButton)
        
        emailTextField.delegate = self
        passwordSecureField.delegate = self
        
        subview.snp.makeConstraints { (make) in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeArea.bottom)
        }
        
        logoView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 60, left: 20, bottom: 350, right: 20))
        }
        emailTextField.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 520, left: 60, bottom: 320, right: 60))
        }
        
        passwordSecureField.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 610, left: 60, bottom: 230, right: 60))
        }
        
        //на SE не видно кнопки
        enterButton.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 700, left: 60, bottom: 130, right: 60))
        }
        
        let tap = UITapGestureRecognizer(target: self.view , action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
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
