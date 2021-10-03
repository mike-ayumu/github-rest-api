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
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: RepositoryListPresenterInterface!
    
    private let repos = [
        Repo(id: 1, name: "jquery", description: "jQuery JavaScript Library"),
        Repo(id: 2, name: "jquery", description: "jQuery JavaScript Library"),
        Repo(id: 3, name: "jquery", description: "jQuery JavaScript Library"),
        Repo(id: 4, name: "jquery", description: "jQuery JavaScript Library"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "RepositoryRowTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
    }
}

// MARK: - RepositoryListViewInterface
extension RepositoryListViewController: RepositoryListViewInterface {
    func tableReloadData() {
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryRowTableViewCell
        cell.cellSetUp(repo: repos[indexPath.row])
        return cell
    }
}
