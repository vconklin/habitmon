//
//  HabitTableViewCell.swift
//  Habitmon
//
//  Created by VAL on 2016/08/10.
//  Copyright © 2016年 VAL. All rights reserved.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
  
  // MARK: Properties
  @IBOutlet weak var habitmonImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var levelLabel: UILabel!
  
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
