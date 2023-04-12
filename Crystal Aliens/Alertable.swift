//
//  Alertable.swift
//  Crystal Aliens
//
//  Created by Administrador on 10/04/23.
//

import Foundation
import SpriteKit

protocol Alertable { }
extension Alertable where Self: SKScene {

    func showAlert(withTitle title: String, message: String, placeholder: String = "", action: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                                
        alertController.addTextField { textField in
            textField.placeholder = placeholder
            textField.autocapitalizationType = .allCharacters
        }
        
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            action(alertController.textFields?[0].text ?? "")
        }
        alertController.addAction(okAction)

        view?.window?.rootViewController?.present(alertController, animated: true)
    }
    
}
