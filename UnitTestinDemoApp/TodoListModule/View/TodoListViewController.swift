//
//  TodoListViewController.swift
//  UnitTestinDemoApp
//
//  Created by Waseem Wani on 26/01/23.
//

import UIKit

class TodoListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var viewModel: TodoListViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TodoListViewModel()
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
        let nib = UINib.init(nibName: "TodoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TodoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func populateData() {
        viewModel?.fetchTodos() { [weak self] result in
            switch result {
                case .success:
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    debugPrint(error)
            }
        }
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
