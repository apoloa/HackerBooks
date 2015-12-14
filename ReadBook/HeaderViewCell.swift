//
//  HeaderViewCell.swift
//  ReadBook
//
//  Created by Adrian Polo Alcaide on 14/12/15.
//  Copyright © 2015 Adrian. All rights reserved.
//

import UIKit

class HeaderViewCell: UITableViewCell {

    @IBOutlet weak var titleHeader: UILabel!
    
    var titleHeaderModel : String?{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        if let titleHeaderModel = titleHeaderModel,
            titleHeader = titleHeader{
            titleHeader.text = titleHeaderModel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
}
