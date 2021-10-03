//
//  RepositoryListRouter.swift
//  GitHubClient
//
//  Created by 西村歩夢 on 2021/10/03.
//

import UIKit

protocol RepositoryListRouterInterface: AnyObject {
}

final class RepositoryListRouter: RepositoryListRouterInterface {
    private weak var view: RepositoryListViewInterface!
    
    init(view: RepositoryListViewInterface) {
        self.view = view
    }
}
