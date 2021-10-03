//
//  SearchResult.swift
//  GitHubClient
//
//  Created by 西村歩夢 on 2021/10/03.
//

import Foundation

struct SearchResult: Codable {
    let items: [Repo]
}
