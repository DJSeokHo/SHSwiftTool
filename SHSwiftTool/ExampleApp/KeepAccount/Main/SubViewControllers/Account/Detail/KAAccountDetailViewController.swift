//
//  KAAccountDetailViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/05/01.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit

class KAAccountDetailViewController: UIViewController, KANavigationBarViewHolderDelegate, UITextViewDelegate {

    public static let TAG = "KAAccountDetailViewController"
    
    private var kaNavigationBarViewHolder: KANavigationBarViewHolder!
    
    @IBOutlet var rootView: UIView!
    
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var imageViewPlus: UIImageView!
    
    @IBOutlet var textFieldTitle: UITextField!
    @IBOutlet var textFieldAmount: UITextField!
    @IBOutlet var textViewContent: UITextView!
    @IBOutlet var categoryViewContainer: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var buttonDelete: UIButton!
    
    private var categoryTabLayout: CategoryTabLayout!
    
    private var category: String!
    private var latitude: Double = 0
    private var longitude: Double = 0
    
    private var image: UIImage?
    
    public var navigationBarTitle: String!
    
    public var isNew: Bool!
    
    public var keepAccountInfoBean: KeepAccountInfoBean!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initObserver()
        initNavigationBar()
        hideProgress()
        setListener()
        
        initView()
        SoftKeyboardUtil.tapSpaceToCloseSoftKeyboard(target: self, action: #selector(self.hideKeyboard))
        
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func hideKeyboard() {
        
        // 除了用 self.view.endEditing(true)
        // 也可以用 resignFirstResponder()
        self.textFieldTitle!.resignFirstResponder()
        self.textFieldAmount!.resignFirstResponder()
        self.textViewContent!.resignFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        LocationWrapper.getInstance().initLocation()
        LocationWrapper.getInstance().requestLocation({
            
            AlertViewUtil.showTwoButtonAlertView(from: self, setTitle: "Permission", setMessage: "You need agree location permission", setConfirmButtonTitle: "Confirm", setCancelButtonTitle: "Cancel", setConfirmDelegate: {
                _ in
                
                PermissionUtil.openAppSettingPage()
               
            }, setCancelDelegate: {
                _ in
                ViewControllerUtil.finishSelf(view: self)
            })
            
        }, onLocateFinished: {
            
            self.latitude = LocationWrapper.getInstance().currentLocation.coordinate.latitude
            self.longitude = LocationWrapper.getInstance().currentLocation.coordinate.longitude
        })
    }
    
    private func initObserver() {
        
        NotificationUtil.addObserver(observer: self, selector: #selector(observerConfirmImage), name: KANotificationConstants.REQUEST_CONFRIM_IMAGE)
        
    }
    @objc func observerConfirmImage(notfication: NSNotification) {
        
        let userInfo = notfication.userInfo
        let image = userInfo!["image"] as! UIImage
       
        imageView.image = image
        imageViewPlus.isHidden = true
        
        self.image = image
        
        ILog.debug(tag: #file, content: image.imageOrientation.rawValue)
    }
    
    private func initView() {
        initTextViewContent()
        initTitleAndAmountTextField()
        initImageView()
        initCategory()
        
        if isNew {
            buttonDelete.isHidden = true
        }
        else {
            buttonDelete.isHidden = false
        }
    }
    
    private func initCategory() {
        
        if categoryTabLayout != nil {
            return
        }
       
        categoryTabLayout = CategoryTabLayout();
        categoryTabLayout.categoryArray.removeAll()
        
        categoryTabLayout.categoryArray.append(KAConstants.CATEGORY_OTHER)
        categoryTabLayout.categoryArray.append(KAConstants.CATEGORY_SHOPPING)
        categoryTabLayout.categoryArray.append(KAConstants.CATEGORY_RESTAURANT)
        categoryTabLayout.categoryArray.append(KAConstants.CATEGORY_CULTURAL)
        categoryTabLayout.categoryArray.append(KAConstants.CATEGORY_TRAVEL)
        categoryTabLayout.categoryArray.append(KAConstants.CATEGORY_MEDICAL)
        categoryTabLayout.categoryArray.append(KAConstants.CATEGORY_STUDY)
        
        category = categoryTabLayout.currentCategory
        
        categoryTabLayout.frame = CGRect(x: 0, y: 0, width: categoryViewContainer.frame.width, height: categoryViewContainer.frame.height)
        
        categoryTabLayout.onTabSelect = {
            self.category = self.categoryTabLayout.currentCategory
        }
        
        categoryTabLayout.initTabLayout()
        
        categoryViewContainer.addSubview(categoryTabLayout.collectionView)
    }
    
    private func initTitleAndAmountTextField() {
        
        textFieldTitle.attributedPlaceholder = NSAttributedString(string: "Input title",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        textFieldTitle.layer.borderColor = UIColor.lightGray.cgColor
        textFieldTitle.layer.borderWidth = 1.0
        textFieldTitle.layer.cornerRadius = 5.0
        
        
        textFieldAmount.attributedPlaceholder = NSAttributedString(string: "Input amount",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        textFieldAmount.layer.borderColor = UIColor.lightGray.cgColor
        textFieldAmount.layer.borderWidth = 1.0
        textFieldAmount.layer.cornerRadius = 5.0
    }
    
    private func initTextViewContent() {
        textViewContent.layer.borderColor = UIColor.lightGray.cgColor
        textViewContent.layer.borderWidth = 1.0
        textViewContent.layer.cornerRadius = 5.0
        
        if textViewContent.text == "" {
            textViewContent.text = "Input content";
            textViewContent.textColor = UIColor.lightGray
        }
        else {
            textViewContent.textColor = UIColor.black
        }
    }
    
    private func initImageView() {
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1.0
        imageView.layer.cornerRadius = 5.0
    }
    
    private func setListener() {
        textViewContent.delegate = self
        TapUtil.addTapListener(viewGroup: self, target: imageView, action: #selector(onImageViewClick))
        TapUtil.addTapListener(viewGroup: self, target: imageViewPlus, action: #selector(onImageViewClick))
        buttonDelete.addTarget(self, action: #selector(onButtonDeleteClick), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func onButtonDeleteClick(_ sender: UIButton) {
        AlertViewUtil.showTwoButtonAlertView(from: self, setTitle: "Alert", setMessage: "Delete record?", setConfirmButtonTitle: "Delete", setCancelButtonTitle: "Cancel", setConfirmDelegate: {
            _ in
            
            // delete record here
            
        })
    }
    
    @objc private func onImageViewClick(_ sender: UIButton) {
        ILog.debug(tag: #file, content: "add image")
        
        let kaCapturePictureViewController = KACapturePictureViewController()
        ViewControllerUtil.startNewFullScreenViewControllerWithNavigation(from: self, target: kaCapturePictureViewController)
    }

    // MARK: text view delegate
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.count < 1 {
            textView.text = "Input content";
            textView.textColor = UIColor.lightGray
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "Input content" {
            textView.text = "";
            textView.textColor = UIColor.black
        }
        
    }
    // MARK: text view delegate
    
    // MARK: navigation bar
    private func initNavigationBar() {
        
        if kaNavigationBarViewHolder != nil {
            return
        }
        
        kaNavigationBarViewHolder = KANavigationBarViewHolder(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80))
        kaNavigationBarViewHolder.kaNavigationBarViewHolderDelegate = self
        
        kaNavigationBarViewHolder.setTitle(title: navigationBarTitle)
        kaNavigationBarViewHolder.setRightButtonImage(imageName: "icon_save.png")
        kaNavigationBarViewHolder.setLeftButtonImage(imageName: "icon_close_black.png")
        
        ViewUtil.setShadow(view: kaNavigationBarViewHolder.bottomLine, color: UIColor.black.cgColor, radius: 1, opacity: 0.3, offsetWidth: 0, offsetHeight: 1)
        
        self.view.addSubview(kaNavigationBarViewHolder!)
    }
    
    // MARK: navigation delegate
    func onLeftButtonClick() {
        ViewControllerUtil.finishSelf(view:self)
    }
    
    func onRightButtonClick() {
        ILog.debug(tag: #file, content: "onRightButtonClick")
        checkInput()
        
    }
    // MARK: navigation delegate
    
    private func updateView() {
        
        if isNew && keepAccountInfoBean == nil {
            return
        }
        
        ILog.debug(tag: #file, content: keepAccountInfoBean.toString())
        let imageUrl = keepAccountInfoBean.imageUrl

        let tempInfo = imageUrl!.split(separator: "_").last
        let o = tempInfo!.split(separator: ".").first
        let oValue = (o! as NSString).intValue

        self.category = keepAccountInfoBean.category
        self.image = StorageUtil.loadImageFile(pathName: StorageUtil.getLibraryDirectory(), folderName: KAConstants.IMAGE_FOLDER_NAME, imageName: imageUrl!, orientation: ImageUtil.getImageOrientation(rawValue: Int(oValue)))

        ThreadUtil.startUIThread(runnable: {

            self.textFieldTitle.text = self.keepAccountInfoBean.title
            self.textFieldAmount.text = String(self.keepAccountInfoBean.amount)
            self.textViewContent.text = self.keepAccountInfoBean.content
            self.imageView.image = self.image
            self.imageViewPlus.isHidden = true

            self.categoryTabLayout.setCategory(category: self.category)

            self.initTextViewContent()

        }, after: 0)
    }
    
    private func checkInput() {
        
        let title = textFieldTitle.text
        if title == "" {
            AlertViewUtil.showOneButtonAlertView(from: self, setTitle: "Alert", setMessage: "Input title please", setButtonTitle: "Confirm")
            return
        }
        
        let amount = textFieldAmount.text
        if amount == "" {
            AlertViewUtil.showOneButtonAlertView(from: self, setTitle: "Alert", setMessage: "Input amount please", setButtonTitle: "Confirm")
            return
        }
        
        let content = textViewContent.text
        if content == "" || content == "Input content" {
            AlertViewUtil.showOneButtonAlertView(from: self, setTitle: "Alert", setMessage: "Input content please", setButtonTitle: "Confirm")
            return
        }
        
        if latitude == 0 || longitude == 0 {
            
            AlertViewUtil.showOneButtonAlertView(from: self, setTitle: "Alert", setMessage: "Locating...", setButtonTitle: "Confirm")
            return
        }
      
        if image == nil {
            
            AlertViewUtil.showOneButtonAlertView(from: self, setTitle: "Alert", setMessage: "Take a photo please", setButtonTitle: "Confirm")
            return
        }
        
        if isNew && keepAccountInfoBean == nil {
            saveInfo()
        }
        else {
            modifyInfo()
        }
    }
    
    private func saveInfo() {
        
        let title = textFieldTitle.text
        let amount = textFieldAmount.text
        let content = textViewContent.text
        let uuid = UUIDUtil.getUUID()
        let orientationRawValue = image!.imageOrientation.rawValue
        let imageUrl = "\(uuid)_orv_\(orientationRawValue).png"
            
        showProgress()
        
        ThreadUtil.startThread(runnable: {
          
            let storageSuccess: Bool = StorageUtil.saveImageFile(
                pathName: StorageUtil.getLibraryDirectory(),
                   folderName: KAConstants.IMAGE_FOLDER_NAME,
                   imageName: imageUrl,
                   image: self.image!)
               
            if !storageSuccess {

                ThreadUtil.startUIThread(runnable: {

                    self.hideProgress()
                    ILog.debug(tag: #file, content: "success")
                }, after: 0)

                return
            }
            
            self.keepAccountInfoBean = KeepAccountInfoBean()
            self.keepAccountInfoBean.uuid = uuid
            self.keepAccountInfoBean.title = title
            self.keepAccountInfoBean.category = self.category
            self.keepAccountInfoBean.amount = (amount! as NSString).floatValue
            self.keepAccountInfoBean.content = content
            self.keepAccountInfoBean.dateTime = DateUtil.getCurrentDateTimeStringWithStandardSQLiteDateTimeFromatter()
            self.keepAccountInfoBean.imageUrl = imageUrl
            self.keepAccountInfoBean.latitude = self.latitude
            self.keepAccountInfoBean.longitude = self.longitude
            
            KADBWrapper.getInstance().insert(keepAccountInfoBean: self.keepAccountInfoBean)
            
            ThreadUtil.startUIThread(runnable: {

                AlertViewUtil.showOneButtonAlertView(from: self, setTitle: "Alert", setMessage: "Save success", setButtonTitle: "Confirm", confirmDelegate: {
                    _ in
                    
                    NotificationUtil.post(name: KANotificationConstants.REQUEST_REFRESH_LIST, object: self)
                    
                    ViewControllerUtil.finishSelf(view: self)
                })
                
                self.hideProgress()
                ILog.debug(tag: #file, content: "success")
            }, after: 0)
        })
    }
    
    private func modifyInfo() {
        
        let title = textFieldTitle.text
        let amount = textFieldAmount.text
        let content = textViewContent.text
        let uuid = keepAccountInfoBean.uuid
        let orientationRawValue = image!.imageOrientation.rawValue
        let imageUrl = "\(uuid!)_orv_\(orientationRawValue).png"
            
        showProgress()
        
        ThreadUtil.startThread(runnable: {
          
            let storageSuccess: Bool = StorageUtil.saveImageFile(
                pathName: StorageUtil.getLibraryDirectory(),
                   folderName: KAConstants.IMAGE_FOLDER_NAME,
                   imageName: imageUrl,
                   image: self.image!)
               
            if !storageSuccess {

                ThreadUtil.startUIThread(runnable: {

                    self.hideProgress()
                    ILog.debug(tag: #file, content: "success")
                }, after: 0)

                return
            }
            
            self.keepAccountInfoBean.title = title
            self.keepAccountInfoBean.category = self.category
            self.keepAccountInfoBean.amount = (amount! as NSString).floatValue
            self.keepAccountInfoBean.content = content
            self.keepAccountInfoBean.imageUrl = imageUrl
            
            KADBWrapper.getInstance().updateData(keepAccountInfoBean: self.keepAccountInfoBean)
            
            ThreadUtil.startUIThread(runnable: {

                AlertViewUtil.showOneButtonAlertView(from: self, setTitle: "Alert", setMessage: "Save success", setButtonTitle: "Confirm", confirmDelegate: {
                    _ in
                    
                    NotificationUtil.post(name: KANotificationConstants.REQUEST_REFRESH_LIST, object: self)
                    
                    ViewControllerUtil.finishSelf(view: self)
                })
                
                self.hideProgress()
                ILog.debug(tag: #file, content: "success")
            }, after: 0)
        })
    }
    
    private func showProgress() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    private func hideProgress() {
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    deinit {
        NotificationUtil.removeAllObserver(observer: self)
    }
    
    // MARK: navigation bar
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
