import SnapKit
import Foundation

class HoumViewController: UIViewController, UITextFieldDelegate {
    
    let subview: UIView = {
        let view = UIView()

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(subview)
        view.backgroundColor = .white
        subview.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
            make.bottom.equalTo(view.safeArea.bottom)
        }
    }
    
    
    
    
}

