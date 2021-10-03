//
//  RepositoryListPresenter.swift
//  GitHubClient
//
//  Created by 西村歩夢 on 2021/10/03.
//

import Foundation

protocol RepositoryListPresenterInterface: AnyObject {
}

final class RepositoryListPresenter {
    private let interactor: RepositoryListInteractorInterface
    private let router: RepositoryListRouterInterface
    
    private weak var view: RepositoryListViewInterface!
    
    init(interactor: RepositoryListInteractorInterface,
         router: RepositoryListRouterInterface,
         view: RepositoryListViewInterface) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension RepositoryListPresenter: RepositoryListPresenterInterface {
}

