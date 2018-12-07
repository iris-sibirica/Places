//
//  TableViewCell.swift
//  PlacesDemo
//
//  Created by Jelena Cvokic on 03.12.18.
//  Copyright © 2018 Jelena Cvokic. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setTitleLabel(text: String?) {
        guard let text = text else { return }
        titleLabel.text = text
    }
}
