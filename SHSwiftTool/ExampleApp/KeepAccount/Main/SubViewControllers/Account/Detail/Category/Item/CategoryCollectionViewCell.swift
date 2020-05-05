//
//  CategoryCollectionViewCell.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/03.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    public static let TAG = "CategoryCollectionViewCell"

    @IBOutlet var labelCategoryTitle: UILabel!
    
    public var category: String!
    
    public var onClickDelegate: ((_ category: String) -> ())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setListener()
    }

    private func setListener() {
        TapUtil.addTapListener(viewGroup: self, target: labelCategoryTitle, action: #selector(onLabelClick))
    }
    
    @objc private func onLabelClick(_ sender: Any) {
        ILog.debug(tag: #file, content: "\(category!)")
        onClickDelegate(category)
    }
    
    public func updateView(color: UIColor) {
        
        labelCategoryTitle?.layer.borderColor = color.cgColor
        if color == UIColor.black {
            labelCategoryTitle?.layer.borderWidth = 1.5
        }
        else {
            labelCategoryTitle?.layer.borderWidth = 1.0
        }
        
        labelCategoryTitle?.layer.cornerRadius = 15.0
        
        labelCategoryTitle?.textColor = color
        
        labelCategoryTitle?.text = category
    }
    
}
