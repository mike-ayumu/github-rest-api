//
//  RepositoryListRouter.swift
//  GitHubClient
//
//  Created by 西村歩夢 on 2021/10/03.
//

import UIKit
import SafariServices

protocol RepositoryListRouterInterface: AnyObject {
    func openURLBySafari(url: String)
}

final class RepositoryListRouter: RepositoryListRouterInterface {
    private weak var view: RepositoryListViewController!
    
    init(view: RepositoryListViewController) {
        self.view = view
    }
    
    func openURLBySafari(url: String) {
        guard let htmlUrl = URL(string: url) else {return}
        let safari = SFSafariViewController(url: htmlUrl)
        self.view.present(safari, animated: true, completion: nil)
    }
}
