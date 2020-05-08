//
//  KAAccountListItemTableViewCell.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class KAAccountListItemTableViewCell: UITableViewCell, KACell {
    
    public static let TAG = "KAAccountListItemTableViewCell"
 
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDateTime: UILabel!
    @IBOutlet var labelAmount: UILabel!
    @IBOutlet var imageViewMain: UIImageView!
    @IBOutlet var imageViewCategory: UIImageView!
    
    public var kaBean: KABean!
    
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
          
        if kaBean == nil {

            return
        }
           
        var userInfo = Dictionary<AnyHashable, Any>()
        userInfo["kaBean"] = kaBean
           
        NotificationUtil.post(name: KANotificationConstants.REQUEST_EDIT_LIST_ITEM, object: self, userInfo: userInfo)
    }
    
    func setData(kaBean: KABean) {
        self.kaBean = kaBean
    }
    
    func updateView() {
        
        let keepAccountInfoBean: KeepAccountInfoBean = kaBean as! KeepAccountInfoBean
        labelTitle.text = keepAccountInfoBean.title
        labelAmount.text = String(keepAccountInfoBean.amount)
        labelDateTime.text = keepAccountInfoBean.dateTime
        
        // category image
        switch keepAccountInfoBean.category {
            case KAConstants.CATEGORY_OTHER:
                imageViewCategory.image = UIImage(named: "icon_category_other.png")
            case KAConstants.CATEGORY_SHOPPING:
                imageViewCategory.image = UIImage(named: "icon_category_shopping.png")
            case KAConstants.CATEGORY_RESTAURANT:
                imageViewCategory.image = UIImage(named: "icon_category_restaurant.png")
            case KAConstants.CATEGORY_CULTURAL:
                imageViewCategory.image = UIImage(named: "icon_category_cultural.png")
            case KAConstants.CATEGORY_TRAVEL:
                imageViewCategory.image = UIImage(named: "icon_category_travel.png")
            case KAConstants.CATEGORY_MEDICAL:
                imageViewCategory.image = UIImage(named: "icon_category_medical.png")
            case KAConstants.CATEGORY_STUDY:
                imageViewCategory.image = UIImage(named: "icon_category_study.png")
            default:
                imageViewCategory.image = UIImage(named: "icon_category_other.png")
        }
        
        // image
        let imageUrl = keepAccountInfoBean.imageUrl
        let tempInfo = imageUrl!.split(separator: "_").last
        let o = tempInfo!.split(separator: ".").first
        let oValue = (o! as NSString).intValue

        let image = StorageUtil.loadImageFile(pathName: StorageUtil.getLibraryDirectory(), folderName: KAConstants.IMAGE_FOLDER_NAME, imageName: imageUrl!, orientation: ImageUtil.getImageOrientation(rawValue: Int(oValue)))
        
        self.imageViewMain.image = image
    }
}
