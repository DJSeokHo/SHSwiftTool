//
//  MainViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 21/06/2019.
//  Copyright © 2019 SWein. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private static let TAG = "MainViewController"
    
    private var navigationBarViewHolder: NavigationBarViewHolder?
    
    public var width: CGFloat?
    
    @IBOutlet var buttonBasicUIViewController: UIButton!
    @IBOutlet var buttonBasicNavigationController: UIButton!
    @IBOutlet var buttonLogin: UIButton!
    @IBOutlet var buttonCamera: UIButton!
    @IBOutlet var buttonBasicLabel: UIButton!
    @IBOutlet var buttonBasicTextField: UIButton!
    @IBOutlet var buttonBasicTextView: UIButton!
    @IBOutlet var buttonBasicButton: UIButton!
    @IBOutlet var buttonBasicAlert: UIButton!
    @IBOutlet var buttonBasicImage: UIButton!
    @IBOutlet var buttonBasicDatePicker: UIButton!
    @IBOutlet var buttonBasicPicker: UIButton!
    @IBOutlet var buttonBasicPickerDemo: UIButton!
    @IBOutlet var buttonBasicSwitch: UIButton!
    @IBOutlet var buttonSegment: UIButton!
    @IBOutlet var buttonProgress: UIButton!
    @IBOutlet var buttonBasicSlider: UIButton!
    @IBOutlet var buttonStepper: UIButton!
    @IBOutlet var buttonBasicWebView: UIButton!
    @IBOutlet var buttonBasicTableView: UIButton!
    @IBOutlet var buttonBasicScrollView: UIButton!
    @IBOutlet var buttonBasicViewPager: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ILog.debug(tag: MainViewController.TAG, content: "viewDidLoad")
        basicConsoleTest()
        
        setListener()
    
    }
    
    private func setListener() {
        buttonBasicUIViewController.addTarget(self, action: #selector(self.onButtonBasicUIViewControllerClick(_:)), for: UIControl.Event.touchUpInside)

        buttonBasicNavigationController.addTarget(self, action: #selector(self.onButtonBasicNavigationControllerClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonLogin.addTarget(self, action: #selector(self.onButtonLoginClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonCamera.addTarget(self, action: #selector(self.onButtonCameraClick(_:)), for: UIControl.Event.touchUpInside)
    
        buttonBasicLabel.addTarget(self, action: #selector(self.onButtonBasicLabelClick(_:)), for: UIControl.Event.touchUpInside)
    
        buttonBasicTextField.addTarget(self, action: #selector(self.onButtonBasicTextFieldClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicTextView.addTarget(self, action: #selector(self.onButtonBasicTextViewClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicButton.addTarget(self, action: #selector(self.onButtonBasicButtonClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicAlert.addTarget(self, action: #selector(self.onButtonBasicAlertClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicImage.addTarget(self, action: #selector(self.onButtonBasicViewClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicDatePicker.addTarget(self, action: #selector(self.onButtonBasicDatePickerClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicPicker.addTarget(self, action: #selector(self.onButtonBasicPickerClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicPickerDemo.addTarget(self, action: #selector(self.onButtonBasicPickerDemoClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicSwitch.addTarget(self, action: #selector(self.onButtonBasicSwitchClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonSegment.addTarget(self, action: #selector(self.onButtonSegmentClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonProgress.addTarget(self, action: #selector(self.onButtonProgressClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicSlider.addTarget(self, action: #selector(self.onButtonBasicSliderClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonStepper.addTarget(self, action: #selector(self.onButtonStepper(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicWebView.addTarget(self, action: #selector(self.onButtonBasicWebView(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicTableView.addTarget(self, action: #selector(self.onButtonTableViewClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicScrollView.addTarget(self, action: #selector(self.onButtonBasicScrollClick(_:)), for: UIControl.Event.touchUpInside)
        
        buttonBasicViewPager.addTarget(self, action: #selector(self.onButtonBasicViewPager(_:)), for: UIControl.Event.touchUpInside)
    }
    
    /*
     go to basic ui view controller template
     */
    @objc private func onButtonBasicUIViewControllerClick(_ sender: UIButton) {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonBasicUIViewControllerClick")
        
        let basicUIViewController = BasicUIViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicUIViewController)
    }
    
    /*
     go to basic navigation controller template
     */
    @objc private func onButtonBasicNavigationControllerClick(_ sender: UIButton) {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonBasicNavigationControllerClick")
        
        let navigationRootViewController = NavigationRootViewController()
        ViewControllerUtil.startNewViewControllerWithNavigation(from: self, target: navigationRootViewController)
    }
    
    @objc private func onButtonLoginClick(_ sender: UIButton) {
        ILog.debug(tag: MainViewController.TAG, content: "onButtonLoginClick")
        
        let loginHomeViewController = LoginHomeViewController()
        loginHomeViewController.fromWhere = "From \(MainViewController.TAG)"
        
        ViewControllerUtil.startNewViewControllerWithNavigation(from: self, target: loginHomeViewController)
    }
    
    @objc private func onButtonCameraClick(_ sender: UIButton) {
        let cameraViewController = CameraViewController()
        cameraViewController.width = self.view.frame.width
        ViewControllerUtil.startNewViewController(from: self, target: cameraViewController)
    }
    
    @objc private func onButtonBasicLabelClick(_ sender: UIButton) {
        let basicLabelViewController = BasicLabelViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicLabelViewController)
    }
    
    @objc private func onButtonBasicTextFieldClick(_ sender: UIButton) {
        let basicTextFieldViewController = BasicTextFieldViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicTextFieldViewController)
    }
    
    @objc private func onButtonBasicTextViewClick(_ send: UIButton) {
        let basicTextViewViewController = BasicTextViewViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicTextViewViewController)
    }
    
    @objc private func onButtonBasicButtonClick(_ send: UIButton) {
        let basicButtonViewController = BasicButtonViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicButtonViewController)
    }
    
    @objc private func onButtonBasicAlertClick(_ send: UIButton) {
        let basicAlertViewController = BasicAlertViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicAlertViewController)
    }
    
    @objc private func onButtonBasicViewClick(_ send: UIButton) {
        let basicBasicImageViewController = BasicImageViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicBasicImageViewController)
    }
    
    @objc private func onButtonBasicDatePickerClick(_ send: UIButton) {
        let basicDatePickerViewController = BasicDatePickerViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicDatePickerViewController)
    }
    
    @objc private func onButtonBasicPickerClick(_ send: UIButton) {
        let basicPickerViewController = BasicPickerViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicPickerViewController)
    }
    
    @objc private func onButtonBasicPickerDemoClick(_ send: UIButton) {
        let basicPickerViewDemoViewController = BasicPickerViewDemoViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicPickerViewDemoViewController)
    }
    
    @objc private func onButtonBasicSwitchClick(_ send: UIButton) {
        let basicSwitchViewController = BasicSwitchViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicSwitchViewController)
    }
    
    @objc private func onButtonSegmentClick(_ send: UIButton) {
        let basicSegmentViewController = BasicSegmentViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicSegmentViewController)
    }
    
    @objc private func onButtonProgressClick(_ send: UIButton) {
        let basicProgressViewController = BasicProgressViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicProgressViewController)
    }
    
    @objc private func onButtonBasicSliderClick(_ send: UIButton) {
        let basicSliderViewController = BasicSliderViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicSliderViewController)
    }
    
    @objc private func onButtonStepper(_ send: UIButton) {
        let basicStepperViewController = BasicStepperViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicStepperViewController)
    }
    
    @objc private func onButtonBasicWebView(_ send: UIButton) {
        let basicWebViewController = BasicWebViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicWebViewController)
    }
    
    @objc private func onButtonTableViewClick(_ send: UIButton) {
        let basicTableViewController = BasicTableViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicTableViewController)
    }
    
    @objc private func onButtonBasicScrollClick(_ send: UIButton) {
        let basicScrollViewController = BasicScrollViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicScrollViewController)
    }
    
    @objc private func onButtonBasicViewPager(_ send: UIButton) {
        let basicViewPagerViewController = BasicViewPagerViewController()
        ViewControllerUtil.startNewViewController(from: self, target: basicViewPagerViewController)
    }
    
    private func basicConsoleTest() {
        showPaths()

//        let basicConsoleTest = BasicConsoleTest()
//        basicConsoleTest.basicGrammarTest()
//        basicConsoleTest.basicStringTest()
//        basicConsoleTest.basicCollectionTest()
//        basicConsoleTest.basicControlFlowTest()
//        basicConsoleTest.basicFunctionTest()
//        basicConsoleTest.basicClassAndStruct()
//        basicConsoleTest.basicInherit()
//        basicConsoleTest.basicFoundation()
    }
   
    private func showPaths() {
        StorageUtil.getAppSandBoxDirectory()
        StorageUtil.getDocumentDirectory()
        StorageUtil.getTempDirectory()
        StorageUtil.getLibraryDirectory()
        StorageUtil.getLibraryCachesDirectory()
    }
   
    deinit {
        ILog.debug(tag: MainViewController.TAG, content: "deinit")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
