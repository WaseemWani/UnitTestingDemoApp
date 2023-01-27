//
//  TodoTableViewCell.swift
//  UnitTestinDemoApp
//
//  Created by Waseem Wani on 26/01/23.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    
    @IBOutlet var todoStatusLabel: UILabel!
    @IBOutlet var todoTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.layer.cornerRadius = 0
    }
    
    func configure(with todo: Todo?) {
        todoTitleLabel.text = todo?.title
        if todo?.completed ?? true {
            todoStatusLabel.text = "Completed"
            todoStatusLabel.textColor = .green
        } else {
            todoStatusLabel.text = "InComplete"
            todoStatusLabel.textColor = .red
        }
    }
    
    func roundCorners(_ corners: CACornerMask) {
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.layer.maskedCorners = corners
    }
}
