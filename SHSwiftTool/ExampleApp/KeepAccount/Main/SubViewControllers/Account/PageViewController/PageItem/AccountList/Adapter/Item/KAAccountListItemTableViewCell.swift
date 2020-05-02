//
//  KAAccountListItemTableViewCell.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class KAAccountListItemTableViewCell: UITableViewCell {
    
    public static let TAG = "KAAccountListItemTableViewCell"
 
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDateTime: UILabel!
    @IBOutlet var labelAmount: UILabel!
    @IBOutlet var imageViewMain: UIImageView!
    @IBOutlet var imageViewCategory: UIImageView!
    
    public var keepAccountInfoBean: KeepAccountInfoBean!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setListener()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setListener() {
     
        TapUtil.addTapListener(viewGroup: self, target: self, action: #selector(singleTapped))
        
    }
    
    @objc func singleTapped(_ recognizer: UITapGestureRecognizer) {
          
        if keepAccountInfoBean == nil {

            return
        }
           
        var userInfo = Dictionary<AnyHashable, Any>()
        userInfo["keepAccountInfoBean"] = keepAccountInfoBean
           
        NotificationUtil.post(name: KANotificationConstants.REQUEST_EDIT_LIST_ITEM, object: self, userInfo: userInfo)
    }
    
    func updateView() {
        
        labelTitle.text = keepAccountInfoBean.title
        labelAmount.text = String(keepAccountInfoBean.amount)
        labelDateTime.text = keepAccountInfoBean.dateTime
        
        // image
    }
}
