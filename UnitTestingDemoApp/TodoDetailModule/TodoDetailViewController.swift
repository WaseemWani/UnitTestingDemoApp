//
//  TodoDetailViewController.swift
//  UnitTestingDemoApp
//
//  Created by Waseem Wani on 29/01/23.
//

import UIKit

class TodoDetailViewController: UIViewController {

    @IBOutlet var userIdLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var todoIdLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    var viewModel: TodoDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Todo Details"
        populateData()
    }
    
    func populateData() {
        guard let id = viewModel?.toDoId else { return }
        viewModel?.fetchTodo(by: id) { [weak self] result in
            switch result {
                case .success:
                    DispatchQueue.main.async {
                        self?.userIdLabel.text = "\(self?.viewModel?.todo?.userId ?? 0)"
                        self?.todoIdLabel.text = "\(self?.viewModel?.todo?.id ?? 0)"
                        self?.titleLabel.text = self?.viewModel?.todo?.title
                        
                    }
                case .failure(let error):
                    debugPrint(error)
            }
        }
    }
}
