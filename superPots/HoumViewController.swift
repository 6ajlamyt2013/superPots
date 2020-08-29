import SnapKit
import Foundation

class HoumViewController: UIViewController, UITextFieldDelegate {
    
    let subview: UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(subview)
        view.backgroundColor = .red
        
        subview.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
            make.bottom.equalTo(view.safeArea.bottom)
        }
    }
    
    
    
    
}

