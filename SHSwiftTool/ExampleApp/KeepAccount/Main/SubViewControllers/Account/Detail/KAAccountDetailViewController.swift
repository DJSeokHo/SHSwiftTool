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
    
    @IBOutlet var textFieldTitle: UITextField!
    @IBOutlet var textFieldAmount: UITextField!
    @IBOutlet var textViewContent: UITextView!
    @IBOutlet var categoryViewContainer: UIView!
    @IBOutlet var imageView: UIImageView!
    
    public var navigationBarTitle: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view. 
        initNavigationBar()
        hideProgress()
        setListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initView()
    }
    
    private func initView() {
        initTextViewContent()
        initTitleAndAmountTextField()
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
    
    private func setListener() {
        textViewContent.delegate = self
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
        
    }
    // MARK: navigation delegate
    
    private func showProgress() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    private func hideProgress() {
        indicator.stopAnimating()
        indicator.isHidden = true
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
