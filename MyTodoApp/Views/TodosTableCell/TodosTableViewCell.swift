//
//  TodosTableViewCell.swift
//  MyTodoApp
//
//  Created by zcrome on 7/7/18.
//  Copyright © 2018 Doapps. All rights reserved.
//

import UIKit

class TodosTableViewCell: UITableViewCell {

	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var creationLabel: UILabel!
	
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
