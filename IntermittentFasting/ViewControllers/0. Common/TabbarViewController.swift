//
//  TabbarViewController.swift
//  IntermittentFasting
//
//  Created by sama73 on 2019. 4. 22..
//  Copyright © 2019년 Byunsangjin. All rights reserved.

/**
1.
NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showTabbar"),
								object: nil,
								userInfo: ["isHidden": false, "isAnimation": true])
}

2.
NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showTabbar"),
								object: nil,
								userInfo: ["isHidden": true, "isAnimation": true])

3.
NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showTabbar"),
								object: nil,
								userInfo: ["isHidden": false, "isAnimation": false])

4.
NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showTabbar"),
								object: nil,
								userInfo: ["isHidden": true, "isAnimation": false])
 */


import UIKit

class TabbarViewController: UIViewController {
    
    // 이전 선택 탭인덱스
    var previousIndex:Int = 0
    // 선택 탭인덱스
    var selectedIndex:Int = -1
    
    var arrTabbarControll: [UIViewController] = []

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var vTabbar: UIView!
	@IBOutlet weak var vTabbarHeightConstraint: NSLayoutConstraint!
	
	// 탭바 버튼
	@IBOutlet var arrTabbarButton: [UIButton]!
	// 탭바 버튼 레이블
	@IBOutlet var arrTabbarLabel: [UILabel]!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 탭바 그림자 처리
        vTabbar.layer.masksToBounds = false
        vTabbar.layer.shadowColor = UIColor.black.cgColor
        vTabbar.layer.shadowOffset = CGSize(width: 0, height: -5)
        vTabbar.layer.shadowOpacity = 0.03
        
        // 탭 메인 VC 로드
        var calorieVC: UIViewController?
        if let storyboard = AppDelegate.sharedNamedStroyBoard("Sama73") as? UIStoryboard {
            calorieVC = storyboard.instantiateViewController(withIdentifier: "CalorieMainViewController") as? CalorieMainViewController
        }
        
        var weightVC: UIViewController?
        if let sjbyunSB = AppDelegate.sharedNamedStroyBoard("SjByun") as? UIStoryboard {
            weightVC = sjbyunSB.instantiateViewController(withIdentifier: "WeightMainViewController") as? WeightMainViewController
        }
//        let weightVC = self.storyboard?.instantiateViewController(withIdentifier: "WeightMainViewController") as? WeightMainViewController
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeMainViewController") as? HomeMainViewController
        let jhPark = UIStoryboard.init(name: "JhPark", bundle: nil)
        let boardNavC = jhPark.instantiateViewController(withIdentifier: "BoardNavC") as? UINavigationController
        let boardVC = self.storyboard?.instantiateViewController(withIdentifier: "BoardMainViewController") as? BoardMainViewController
        let settingsVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingsMainViewController") as? SettingsMainViewController

		arrTabbarControll += [calorieVC!]
		arrTabbarControll += [weightVC!]
		arrTabbarControll += [homeVC!]
		arrTabbarControll += [boardNavC!]
		arrTabbarControll += [settingsVC!]
		
        // 홈탭 선택
        selectedTab(2)
        
		
		// 탭바 활성화/비활성화
		NotificationCenter.default.addObserver(self,
											   selector: #selector(self.showTabbar(_:)),
											   name: NSNotification.Name(rawValue: "showTabbar"),
											   object: nil)
    }
	
	@objc func showTabbar(_ notification: NSNotification) {
		if let dict = notification.userInfo as NSDictionary? {
			if let isHidden: Bool = dict["isHidden"] as? Bool, let isAnimation: Bool = dict["isAnimation"] as? Bool {
				// do something
				if isHidden == true && isAnimation == true {
					UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {
						self.vTabbarHeightConstraint.constant = 0
						self.view.layoutIfNeeded()
					}) { finished in
						self.vTabbar.isHidden = true
					}
				} else if isHidden == true && isAnimation == false {
					self.vTabbarHeightConstraint.constant = 0
					self.vTabbar.isHidden = true
				} else if isHidden == false && isAnimation == true {
					self.vTabbar.isHidden = false
					
					UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {
						self.vTabbarHeightConstraint.constant = 64
						self.view.layoutIfNeeded()
					}) { finished in
						
					}
				} else {
					self.vTabbar.isHidden = false
					self.vTabbarHeightConstraint.constant = 64
				}
			}
		}
	}
    
    // 탭 선택 - 버튼 선택 처리
    func selectedTab(_ index: NSInteger) {
        previousIndex = selectedIndex
        selectedIndex = index
        
        // 이전 Tab Index와 같으면
        if previousIndex == selectedIndex {
            print("??")
            return
        }
        
        // 이전탭 해제
        if previousIndex != -1 {
            let vc: UIViewController = arrTabbarControll[previousIndex]
			vc.view.removeFromSuperview()
			vc.removeFromParent()
        }

        for i in 0..<arrTabbarControll.count {
            let vc: UIViewController = arrTabbarControll[i]
			let button: UIButton = arrTabbarButton[i]
			let titleLabel: UILabel = arrTabbarLabel[i]
			if i == index {
				button.isSelected = true
				titleLabel.textColor = UIColor.init(hex: 0xFF7F67)
				
				// 탭 VC 설정
				self.addChild(vc)
				
				vc.view.frame = self.vContent.bounds
				self.vContent.addSubview(vc.view)
			}
			else {
				button.isSelected = false
				titleLabel.textColor = UIColor.init(hex: 0xAEAEAE)
			}
		}
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UIButton Action
    @IBAction func onTabClick(_ sender: UIButton) {
        // 탭 선택
        selectedTab(sender.tag)
    }
}
