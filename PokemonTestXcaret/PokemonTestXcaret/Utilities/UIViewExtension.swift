//
//  UIViewExtension.swift
//  PokemonTestXcaret
//
//  Created by CynthiaDenisse on 1/5/23.
//

import UIKit

extension UIView {
    
    func bindToSuperView(insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)) {
        guard let superSafe = self.superview?.safeAreaLayoutGuide else {
            fatalError("Forgot to add the view to the view hierarchy. FIX IT!")
        }
        
        self.topAnchor.constraint(equalTo: superSafe.topAnchor, constant: insets.top).isActive = true
        self.leadingAnchor.constraint(equalTo: superSafe.leadingAnchor, constant: insets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: superSafe.trailingAnchor, constant: -insets.right).isActive = true
        self.bottomAnchor.constraint(equalTo: superSafe.bottomAnchor, constant: -insets.bottom).isActive = true
    }
    
    
}
