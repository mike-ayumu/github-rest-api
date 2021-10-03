//
//  RepositoryListViewController.swift
//  GitHubClient
//
//  Created by 西村歩夢 on 2021/10/03.
//

import UIKit

protocol RepositoryListViewInterface: AnyObject {
    func tableReloadData()
    func showErrorMessage(message: String)
}

final class RepositoryListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: RepositoryListPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "RepositoryRowTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
        
        presenter.onViewDidLoad()
    }
}

// MARK: - RepositoryListViewInterface
extension RepositoryListViewController: RepositoryListViewInterface {
    func tableReloadData() {
        tableView.reloadData()
    }
    
    func showErrorMessage(message: String) {
        let alert: UIAlertController = UIAlertController(title: "エラー", message:  message, preferredStyle:  UIAlertController.Style.alert)
        
        // 再読み込み処理
        let continueAction: UIAlertAction = UIAlertAction(title: "再読み込み", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            self.presenter.onRetryButtonTapped()
        })
        
        alert.addAction(continueAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RepositoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryRowTableViewCell
        cell.cellSetUp(repo: presenter.repos[indexPath.row])
        return cell
    }
}
