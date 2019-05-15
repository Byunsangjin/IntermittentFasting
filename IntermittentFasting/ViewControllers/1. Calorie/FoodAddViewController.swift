//
//  FoodAddViewController.swift
//  IntermittentFasting
//
//  Created by sama73 on 2019. 4. 29..
//  Copyright © 2019년 Byunsangjin. All rights reserved.
//

import UIKit

class FoodAddViewController: UIViewController {

    @IBOutlet weak var viewPager: ViewPagerContent!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let storyboard: UIStoryboard? = AppDelegate.sharedNamedStroyBoard("Sama73") as? UIStoryboard
        let foodFindVC = storyboard?.instantiateViewController(withIdentifier: "FoodFindViewController") as? FoodFindViewController
        foodFindVC!.title = "음식검색"
        let personalFoodVC = storyboard?.instantiateViewController(withIdentifier: "PersonalFoodViewController") as? PersonalFoodViewController
        personalFoodVC!.title = "개인음식"
        let bookMarkVC = storyboard?.instantiateViewController(withIdentifier: "BookMarkViewController") as? BookMarkViewController
        bookMarkVC!.title = "즐겨찾기"
        
        var viewPagerInfo: ViewPagerInfo = ViewPagerInfo(menuButtonColorNormal: UIColor(hex: 0x000000),
                                                         menuButtonColorSelected: UIColor(hex: 0x60DDB4),
                                                         menuButtonfontSize: 19.0,
                                                         menuButtonHeight: 45.0,
                                                         menuButtonOffsetX: 11.0)
        
        viewPagerInfo.arrChildController = [foodFindVC!, personalFoodVC!, bookMarkVC!]
        
        // 뷰페이저 초기화
        self.viewPager!.initContent(viewPagerInfo)
        
        self.viewPager!.delegate = self
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let notifier = NotificationCenter.default
		notifier.addObserver(self,
							 selector: #selector(self.keyboardWillShow(_:)),
							 name: UIWindow.keyboardWillShowNotification,
							 object: nil)
		
		notifier.addObserver(self,
							 selector: #selector(self.keyboardWillHide(_:)),
							 name: UIWindow.keyboardWillHideNotification,
							 object: nil)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		self.view.endEditing(true)
		NotificationCenter.default.removeObserver(self)
		
		super.viewWillDisappear(animated)
		
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Action
    // 닫기
    @IBAction func onCloseClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
	
	// MARK: - NotificationCenter
	// 인포커싱 되었을때 스크롤뷰 마진값 적용
	@objc func keyboardWillShow(_ notification: NSNotification) {
		print("keyboardWillShow")
		
		if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardRectangle = keyboardFrame.cgRectValue
			
			// iPhoneX 스타일 경우 마진을 34만큼 더준다.
			var gapOffsetY : CGFloat = 0.0
			if CommonUtil.isIphoneX == true {
				gapOffsetY = 34.0
			}
			// 키보드 높이
			let kbSizeHeight : CGFloat = keyboardRectangle.height - gapOffsetY
			
			UIView.animate(withDuration: 0.25, animations: { () -> Void in
				var frame = self.view.frame
				frame.size.height = UIScreen.main.bounds.height - kbSizeHeight
				self.view.frame = frame
				
				self.view.layoutIfNeeded()
			})
		}
	}
	
	// 언포커싱 되었을때 스크롤뷰 마진값 해제
	@objc func keyboardWillHide(_ notification: NSNotification) {
		print("keyboardWillHide")
		
		UIView.animate(withDuration: 0.25, animations: { () -> Void in
			var frame = self.view.frame
			frame.size.height = UIScreen.main.bounds.height
			self.view.frame = frame
			
			self.view.layoutIfNeeded()
		})
	}
}

extension FoodAddViewController: ViewPagerContentDelegate {
    func containerViewItem(_ index: Int) {
        print("메인화면 이벤트=\(index)")
		self.view.endEditing(true)
        
    }
}
