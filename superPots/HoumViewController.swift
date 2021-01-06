import SnapKit
import Foundation

class HoumViewController: UIViewController {
    
    let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        
        return stack
    }()
    
    let headStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        
        return stack
    }()
    
    let plantsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .green
        
        return stack
    }()
    
    let exploreStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .gray
        
        return stack
    }()
    
    lazy var lblMyPlants: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        lbl.text = "My Plants"
        lbl.numberOfLines = 0
        
        return lbl
    }()
    
    lazy var btnButer: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "settingsIcon"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
//        btn.imageView?.clipsToBounds = true
//        btn.imageView?.layer.masksToBounds = true
//        btn.imageView?.isHighlighted = true
        
        
        //btn.addTarget(self, action: #selector(handleAnswer(_:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(mainStackView)
        
        mainStackView.addArangedSubviews(
            headStackView,
            plantsStackView,
            exploreStackView
        )
        
        headStackView.addArangedSubviews(
            lblMyPlants,
            btnButer
        )
        
        mainStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
//        btnButer.snp.makeConstraints { (make) in
//            make.margins.right.equalTo(headStackView).offset( 0)
//        }
                
        plantsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(headStackView).offset(40)
        }
        exploreStackView.snp.makeConstraints { (make) in
            make.top.equalTo(plantsStackView).offset(40)
        }
    }
}

