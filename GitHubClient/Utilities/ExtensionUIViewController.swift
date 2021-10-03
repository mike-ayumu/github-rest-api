//
//  ExtensionUIViewController.swift
//  GitHubClient
//
//  Created by 西村歩夢 on 2021/10/04.
//

import Foundation
import UIKit

extension UIViewController {
    
    /**
     インジケータースタート
     */
    func startIndicator() {
        // インジケーター
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = self.view.center
        loadingIndicator.startAnimating()
        
        // 背景View
        let backgroundView = UIView(frame: self.view.frame)
        backgroundView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        backgroundView.addSubview(loadingIndicator)
        
        // 表示
        self.view.addSubview(backgroundView)
    }
    
    /**
     インジケーターストップ
     */
    func stopIndicator() {
        self.view.subviews.last?.removeFromSuperview()
    }
    
}
