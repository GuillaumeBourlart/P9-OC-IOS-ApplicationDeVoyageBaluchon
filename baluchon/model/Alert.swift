//
//  File.swift
//  baluchon
//
//  Created by Guillaume Bourlart on 01/10/2022.
//

import UIKit
// We create an alert containing the error received, and return it
class Alert {
    
    static func createAlert(with errorMessage: String) -> UIAlertController{
        
        let alert = UIAlertController(title: "Erreur", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Quitter", style: .cancel, handler: nil)
        alert.addAction(action)
      
        return alert
    }
}

