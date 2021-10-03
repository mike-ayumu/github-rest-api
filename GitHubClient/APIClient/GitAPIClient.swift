//
//  GitAPIClient.swift
//  GitHubClient
//
//  Created by 西村歩夢 on 2021/10/03.
//

import Foundation
import Combine

struct GitAPIClient {
    func getRepos(queryItems: [URLQueryItem]) -> AnyPublisher<SearchResult, Error> {
        var compnents = URLComponents(string: "https://api.github.com/search/repositories")
        compnents?.queryItems = queryItems
        let url: URL = (compnents?.url)!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/vnd.github.v3+json"
        ]

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
