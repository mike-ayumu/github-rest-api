//
//  Repo.swift
//  GitHubClient
//
//  Created by 西村歩夢 on 2021/10/03.
//

import Foundation

struct Repo: Codable {
    var name: String
    var description: String?
    var htmlUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case description
        case htmlUrl = "html_url"
    }
}
