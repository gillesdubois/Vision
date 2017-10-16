//
//  MonitoringTableViewCell.swift
//  Vision
//
//  Created by Gilles Dubois on 16/10/2017.
//  Copyright © 2017 Gilles Dubois. All rights reserved.
//

import UIKit

class MonitoringTableViewCell: UITableViewCell {

    @IBOutlet weak var serverName: UILabel!
    @IBOutlet weak var serverUrl: UILabel!
    @IBOutlet weak var monitoringStatus: MonitoringStatus!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
