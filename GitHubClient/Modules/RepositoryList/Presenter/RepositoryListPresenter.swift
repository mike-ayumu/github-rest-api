//
//  RepositoryListPresenter.swift
//  GitHubClient
//
//  Created by 西村歩夢 on 2021/10/03.
//

import Foundation
import Combine

protocol RepositoryListPresenterInterface: AnyObject {
    var repos: [Repo] { get }
    func onSearchButtonTapped(query: String)
    func onRepositoryListCellTapped(url: String)
}

final class RepositoryListPresenter {
    private let interactor: RepositoryListInteractorInterface
    private let router: RepositoryListRouterInterface
    
    private weak var view: RepositoryListViewInterface!
    
    private var cancellables = Set<AnyCancellable>()
    var repos = [Repo]()
    
    init(interactor: RepositoryListInteractorInterface,
         router: RepositoryListRouterInterface,
         view: RepositoryListViewInterface) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension RepositoryListPresenter: RepositoryListPresenterInterface {
    func onSearchButtonTapped(query: String) {
        loadRepository(query: query)
    }
    
    func onRepositoryListCellTapped(url: String) {
        router.openURLBySafari(url: url)
    }
    
    func loadRepository(query: String) {
        let queryItems = [
            URLQueryItem(name: "q", value: query),
        ]
        interactor.fetchRepos(queryItems: queryItems)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.view.showErrorMessage(message: error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] searchResult in
                self?.repos = searchResult.items
                self?.view.tableReloadData()
            }
            ).store(in: &cancellables)
    }
}

