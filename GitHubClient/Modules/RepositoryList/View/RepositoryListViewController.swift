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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: RepositoryListPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "RepositoryRowTableViewCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
        
        // キーボード終了バーとボタンを表示
        showKeyboardCloseBar()
    }
}

// MARK: - RepositoryListViewInterface
extension RepositoryListViewController: RepositoryListViewInterface {
    func tableReloadData() {
        tableView.reloadData()
    }
    
    func showErrorMessage(message: String) {
        let alert: UIAlertController = UIAlertController(title: "エラー", message:  message, preferredStyle:  UIAlertController.Style.alert)
        let continueAction: UIAlertAction = UIAlertAction(title: "完了", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(continueAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UISearchBarDelegate
extension RepositoryListViewController: UISearchBarDelegate {
    // 検索実行時
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        presenter.onSearchButtonTapped(query: searchText)
    }
    
    // キーボードクローズバー設置
    func showKeyboardCloseBar() {
        let keyboardCloseBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        keyboardCloseBar.barStyle = UIBarStyle.default
        keyboardCloseBar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)

        // 閉じるボタン押下時処理
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(keyboardCloseButtonTapped))

        keyboardCloseBar.items = [spacer, commitButton]
        searchBar.inputAccessoryView = keyboardCloseBar
    }
    
    // キーボード終了処理
    @objc func keyboardCloseButtonTapped(){
        searchBar.endEditing(true)
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
