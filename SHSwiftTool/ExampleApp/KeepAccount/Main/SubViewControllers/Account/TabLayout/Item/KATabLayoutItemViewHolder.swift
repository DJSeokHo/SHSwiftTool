//
//  KATabLayoutItemViewHolder.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/02.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class KATabLayoutItemViewHolder: UICollectionViewCell {

    @IBOutlet var label: UILabel!
    
    public var title: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func setListener() {
        TapUtil.addTapListener(viewGroup: self, target: label, action: #selector(onLabelClick))
    }
    
    @objc private func onLabelClick(_ sender: Any) {
        ILog.debug(tag: #file, content: "\(title!)")
    }
    
    public func updateView(color: UIColor) {
        label.text = title
        label.textColor = color
    }

}
