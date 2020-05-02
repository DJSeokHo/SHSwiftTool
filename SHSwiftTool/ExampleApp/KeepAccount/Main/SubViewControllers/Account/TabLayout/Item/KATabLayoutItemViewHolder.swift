//
//  KATabLayoutItemViewHolder.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/02.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class KATabLayoutItemViewHolder: UICollectionViewCell {
    
    public static let TAG = "KATabLayoutItemViewHolder"

    @IBOutlet var label: UILabel!
    
    public var title: String!
    
    public var index: Int!
    
    public var onClickDelegate: ((_ index: Int) -> ())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setListener()
    }

    private func setListener() {
        TapUtil.addTapListener(viewGroup: self, target: label, action: #selector(onLabelClick))
    }
    
    @objc private func onLabelClick(_ sender: Any) {
        ILog.debug(tag: #file, content: "\(title!)")
        onClickDelegate(index)
    }
    
    public func updateView(color: UIColor) {
        label?.text = title
        label?.textColor = color
    }

}
