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
    
    private var categoryTabLayout: CategoryTabLayout!
    
    private var category: String!
    private var latitude: Double = 0
    private var longitude: Double = 0
    
    private var image: UIImage?
    
    public var navigationBarTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initObserver()
        initNavigationBar()
        hideProgress()
        setListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initView()
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
    }
    
    private func initView() {
        initTextViewContent()
        initTitleAndAmountTextField()
        initImageView()
        initCategory()
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

        textViewContent.text = "Input content";
        textViewContent.textColor = UIColor.lightGray
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
    
    private func checkInput() {
        
//        public var uuid: String!
//        public var title: String!
//        public var category: String!
//        public var amount: Float!
//        public var content: String!
//        public var dateTime: String!
//        public var imageUrl: String!
//        public var latitude: Double!
//        public var longitude: Double!
       
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
        
//        var keepAccountInfoBean: KeepAccountInfoBean = KeepAccountInfoBean()
//        if textFieldTitle.text == nil {
//
//        }
//
//         @IBOutlet var textFieldTitle: UITextField!
//         @IBOutlet var textFieldAmount: UITextField!
//         @IBOutlet var textViewContent: UITextView!
//         @IBOutlet var categoryViewContainer: UIView!
//         @IBOutlet var imageView: UIImageView!
    }
    
    private func saveInfo() {
        
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
