//
//  RunLogCell.swift
//  URUN
//
//  Created by Jose M Arguinzzones on 2019-04-22.
//  Copyright © 2019 Jose M Arguinzzones. All rights reserved.
//

import UIKit

class RunLogCell: UITableViewCell {
    
    @IBOutlet var runDurationLbl: UILabel!
    
    @IBOutlet var totalDistanceLbl: UILabel!
    
    @IBOutlet var averagePaceLbl: UILabel!
    
    @IBOutlet var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(run: Run)  {
        runDurationLbl.text = run.duration.formatTimeDurationToString()
        totalDistanceLbl.text = "\(run.distance.metersToMiles(places: 2)) mi"
        averagePaceLbl.text = run.pace.formatTimeDurationToString()
        dateLbl.text = run.date.getDateString()
    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
