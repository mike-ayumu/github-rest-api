//
//  RepositoryListInteractor.swift
//  GitHubClient
//
//  Created by 西村歩夢 on 2021/10/03.
//

import Foundation
import Combine

protocol RepositoryListInteractorInterface: AnyObject {
    func fetchRepos(queryItems: [URLQueryItem]) -> AnyPublisher<SearchResult, Error>
}

final class RepositoryListInteractor: RepositoryListInteractorInterface {
    func fetchRepos(queryItems: [URLQueryItem]) -> AnyPublisher<SearchResult, Error> {
        return GitAPIClient().getRepos(queryItems: queryItems)
    }
}
