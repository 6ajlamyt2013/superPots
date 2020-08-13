import Foundation
import Alamofire
import SwiftyJSON


class NetworkLayer {
    
    static let baseHost = "http://www.superpots.site/api.php"
    
    //нужен enam для методов
    
    static func registrClient (name: String, email: String, password: String, pot: Int, method: String) {
        
        let parametrs: [ String: Any] = ["name": name, "password": password, "pot": pot, "method": method, "email": email]
        
        AF.request(NetworkLayer.baseHost,
                   method: .get,
                   parameters: parametrs)
            
            .validate(statusCode: 200..<300)
            .responseJSON { (responseJSON) in
                switch responseJSON.result {
                case .success(let value):
                    print(value)
                    guard let jsonArray = responseJSON.value as? [String: Any] else { return }
                    if (jsonArray["session"] != nil) {
                        print("session", jsonArray["session"]!)
                    } else {
                        print(jsonArray["error"]!)
                    }
                case .failure(let error):
                    print(error)
                }
                
                
                // methoad use respons and SwiftyJSON
                //                switch response.result {
                //
                //                case .success(let value):
                //                    let json = JSON(value)
                //                    debugPrint(json)
                //                    if let session = json["session"].string {
                //                        debugPrint(session)
                //                    }
                //
                //                case .failure(let error):
                //                    print(error)
                //                }
        }
    }
}

