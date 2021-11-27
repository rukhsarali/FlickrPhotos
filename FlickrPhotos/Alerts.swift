//
//  Alerts.swift
//  FlickrPhotos
//
//  Created by Rukhsar Ali on 26/11/2021.
//

import Foundation
import UIKit
struct Alerts {
    
    static func showAlert(on vc:UIViewController, title:String, message:  String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
    vc.present(alert, animated: true)
    }
    
    static func showAlertView(on vc: UIViewController, with title:String, message : String?) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .cancel,
                                         handler: nil))
           vc.present(alert, animated: true, completion:{
           })
       }
    
}


