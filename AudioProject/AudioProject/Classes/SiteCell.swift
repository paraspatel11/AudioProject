//
//  SiteCell.swift
//  AudioProject
//
//  Created by Xcode User on 2019-03-14.
//  Copyright © 2019 Xcode User. All rights reserved.
//  Author: Paras Patel

import UIKit

class SiteCell: UITableViewCell {

    let primaryLabel = UILabel()
    let secondaryLabel = UILabel()
    let thirdLabel = UILabel()
    
    let myImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        
        primaryLabel.textAlignment = .left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 30)
        primaryLabel.backgroundColor = .clear
        primaryLabel.textColor = .black
        
        secondaryLabel.textAlignment = .left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 15)
        secondaryLabel.backgroundColor = .clear
        secondaryLabel.textColor = .blue
        
        thirdLabel.textAlignment = .left
        thirdLabel.font = UIFont.boldSystemFont(ofSize: 15)
        thirdLabel.backgroundColor = .clear
        thirdLabel.textColor = .red
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
        contentView.addSubview(thirdLabel)
        
        contentView.addSubview(myImageView)
        
        
    }
    
    
    override func layoutSubviews() {
        primaryLabel.frame = CGRect(x: 110, y: 5, width: 460, height: 30)
        secondaryLabel.frame = CGRect(x: 110, y: 40, width: 460, height: 20)
        thirdLabel.frame = CGRect(x: 350, y: 40, width: 460, height: 20)
        
        myImageView.frame = CGRect(x: 5, y: 5, width: 100, height: 85)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented) ")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
