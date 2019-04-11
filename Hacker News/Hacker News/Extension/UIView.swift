//
//  APIManager.swift
//  Hacker News
//
//  Created by Happlabs Software LLP MAC1 on 10/04/19.
//  Copyright © 2019 Farooque. All rights reserved.
//

import UIKit

extension UIView {
    
    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView.init(style: .white)
        
        if let _ = self.viewWithTag(200) as? UIActivityIndicatorView {
            
        } else {
            activityIndicator.center = self.center
            activityIndicator.color = UIColor.blue
            activityIndicator.hidesWhenStopped = true
            activityIndicator.tag = 200
            self.addSubview(activityIndicator)
        }
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        if let activityIndicator = self.viewWithTag(200) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
