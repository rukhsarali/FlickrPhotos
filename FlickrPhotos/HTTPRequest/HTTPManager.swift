//
//  HTTPManage.swift
//  FlickrPhotos
//
//  Created by Rukhsar Ali on 26/11/2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import ProgressHUD
class HTTPManager {
    static let shared: HTTPManager = HTTPManager()
    typealias ErrorType = (String) -> Void
    
    public func get<T: Decodable>(_ apiName: String, withparams parameters: [String:Any] = [:], controller: UIViewController, completion: @escaping (_ response: T) -> Void)
    {
        
        let Urlstring = "\(apiName)"
        //let Urlstring = "\(apiName)"
        let headers: HTTPHeaders = [
            "accesstoken": ""
        ]
        print(Urlstring)
        print(headers)
        print(parameters)
        ProgressHUD.colorAnimation = .systemBlue
        ProgressHUD.animationType = .circleStrokeSpin
        
        ProgressHUD.show("", interaction: false)
        //ProgressHUD.show()
        NetworkManager.isReachable { networkManagerInstance in
            print("Network is available")
            AF.request(Urlstring, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
                ProgressHUD.dismiss()
                switch response.result {
                case .success:
                    // let result = JSON(response.result.value!)
                    let resultt = JSON(response.result)
                    print("Response: \(resultt)")
                    guard let data = response.data else {return}
                    do{
                        let responseObject = try JSONDecoder().decode(T.self, from: data)
                        completion(responseObject)
                    }catch{
                        print ("Error is \(String(describing: error))")
                        Alerts.showAlertView(on: controller, with: "Error!", message: "\(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("erre .failer\(error)")
                    Alerts.showAlertView(on: controller, with: "Error!", message: "\(error.localizedDescription)")
                }
            }
        }
        NetworkManager.isUnreachable { networkManagerInstance in
            print("Network is Unavailable")
            Alerts.showAlertView(on: controller, with: "Error!", message: "Internet not reachable!")
        }
        
    }
    
}//end classHTTP

