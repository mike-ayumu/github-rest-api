//
//  RepositoryListViewController.swift
//  GitHubClient
//
//  Created by 西村歩夢 on 2021/10/03.
//

import UIKit

protocol RepositoryListViewInterface: AnyObject {
}

final class RepositoryListViewController: UIViewController {
    var presenter: RepositoryListPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RepositoryListViewController: RepositoryListViewInterface {
}
