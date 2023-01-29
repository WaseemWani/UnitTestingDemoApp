//
//  TodoListViewController.swift
//  UnitTestinDemoApp
//
//  Created by Waseem Wani on 26/01/23.
//

import UIKit

class TodoListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!

    var viewModel: TodoListViewModel?
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TodoListViewModel(service: NetworkManager())
        setupNavBar()
        setupTableView()
        populateData()
    }
    
    func setupNavBar() {
        title = "My Todos"
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "arrow.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold))
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold))
        navigationController?.navigationBar.tintColor = .black
    }
    
    func setupTableView() {
        tableView.isHidden = true
        let nib = UINib.init(nibName: "TodoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TodoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func populateData() {
        showHideLoadinView(shouldShow: true)
        viewModel?.fetchTodos() { [weak self] result in
            switch result {
                case .success:
                    DispatchQueue.main.async {
                        self?.showHideLoadinView(shouldShow: false)
                        self?.tableView.isHidden = false
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showHideLoadinView(shouldShow: false)
                        self?.showAlert(msg: error.localizedDescription)
                        self?.loadingIndicator.stopAnimating()
                        self?.loadingIndicator.isHidden = true
                    }
                    debugPrint(error)
            }
        }
    }
    
    private func showHideLoadinView(shouldShow: Bool) {
        if shouldShow {
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimating()
        }
    }
    
    private func showAlert(msg: String) {
        let alert = UIAlertController(title: "Oops!", message: msg, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self]_ in
            self?.populateData()
        }
        alert.addAction(retryAction)
        self.present(alert, animated: true)
    }
}

extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.todos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell") as? TodoTableViewCell else {
             return UITableViewCell()
        }
        cell.configure(with: viewModel?.todos[indexPath.row])
        if indexPath.row == 0 {
            cell.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner])
        } else if let count = viewModel?.todos.count, indexPath.row == count - 1 {
            cell.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        }
        return cell
    }
}
