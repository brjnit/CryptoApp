//
//  UIViewController+Extension.swift
//  CryptoApp
//
//  Created by Brajesh Kumar on 20/02/22.
//

import UIKit

extension UIViewController {
    var activityIndicatorTag: Int { return 99}
    func showAlert(title: String? = nil, message: String ) {
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVc.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alertVc, animated: true, completion: nil)
    }
    
    func showLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.tag = strongSelf.activityIndicatorTag
            activityIndicator.hidesWhenStopped = true
            activityIndicator.center = CGPoint(x: strongSelf.view.bounds.minX, y: strongSelf.view.bounds.minY)
            strongSelf.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            
            if let activityIndicator = strongSelf.view.subviews.filter({ $0.tag == strongSelf.activityIndicatorTag }).first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
        
    }
}
