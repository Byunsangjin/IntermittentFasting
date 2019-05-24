//
//  CalorieMainViewController.swift
//  IntermittentFasting
//
//  Created by sama73 on 2019. 4. 23..
//  Copyright © 2019년 Byunsangjin. All rights reserved.
//

import UIKit

class CalorieMainViewController: UIViewController {

	// 오늘 날짜
//	var currentDate: (year: Int, month: Int, day: Int) = CalendarManager.getYearMonthDay(amount: 0)
	
	
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vWaveGage: WaveProgressView!
    @IBOutlet weak var lbCalorie: UILabel!
    @IBOutlet weak var sValue: UISlider!
    @IBOutlet weak var btnFoodAdd: UIButton!
	
	// 음식 목록
	let kScrollViewMargin: CGFloat = 24
	let sinus = sin(Double.pi / 180.0)
	let maxCellVerticalGap: CGFloat = 13.0
	
	// 해상도 폭 - 24 - 24
	let kSubViewWidth: CGFloat = UIScreen.main.bounds.width - 48
	
	// 이전 스크롤 X위치
	var oldContentOffsetX: CGFloat = 0
	
	// 슬라이더 셀
	var arrSubCell: [UIView] = []
	var arrSubCheild: [FoodListViewController] = []
	
	@IBOutlet var scrollView: UIScrollView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 오늘 날짜 선택 날짜 초기화
        CalendarManager.curSelectedDay = CalendarManager.getTodayIndex()
        CalendarManager.newSelectedDay = CalendarManager.curSelectedDay

        sValue.minimumValue = 0
        sValue.maximumValue = 1640
        sValue.setValue(820, animated: false)
        
        if let waveView = self.vWaveGage {
            waveView.waveRate = 2
            waveView.waveSpeed = 1
            waveView.waveHeight = 5
            
            waveView.minimumValue = sValue.minimumValue;
            waveView.maximumValue = sValue.maximumValue;
            waveView.limitValue = 1300
            waveView.value = sValue.value
            
            // 웨이프 프로그레스 원
            waveView.layer.masksToBounds = true
            waveView.layer.borderColor = UIColor.init(hex: 0x60DDB4).cgColor
            waveView.layer.borderWidth = 1
            waveView.layer.cornerRadius = 107
            
            waveView.completion = { percent in  // 웨이브 애니메이션 콜백
                self.lbCalorie.text = "\(Int(waveView.value))"
                // 아바타보기의 y 좌표를 동기화하십시오
                //                self.iconImageView.frame.origin.y = waveViewHeight + centerY - iconImageWidth
            }
            //            waveView.addSubview(iconImageView)
            waveView.startWave()
        }
        
        // 음식 추가 버튼 그림자
        btnFoodAdd.layer.shadowColor = UIColor(hex: 0xFF7F67).cgColor
        btnFoodAdd.layer.shadowOffset = CGSize(width: 0, height: 4)
        btnFoodAdd.layer.shadowOpacity = 0.35
        
        // GUI 초기화
        vWaveGage!.initGUI(color: UIColor.black)
		
        // 화면 갱신
        updateScreen()
		
		
		// 음식 목록
		// 스크롤뷰 초기화
		// 스크롤뷰 마진
		self.scrollView.contentInset = UIEdgeInsets(top: 0, left: kScrollViewMargin, bottom: 0, right: kScrollViewMargin)
		
		// 스크롤뷰 안에 있는 뷰들 제거
		for view in scrollView.subviews {
			view.removeFromSuperview()
		}
		
		// 선택한 년월일 튜플로 변환
		let currentDate = CalendarManager.getSelectedYearMonthDay()
		
		// 스크롤뷰 셀 추가
		let storyboard: UIStoryboard? = AppDelegate.sharedNamedStroyBoard("Sama73") as? UIStoryboard
		for i in 0 ..< 3 {
			let subVC = storyboard?.instantiateViewController(withIdentifier: "FoodListViewController") as? FoodListViewController
			subVC!.currentDate = CalendarManager.getYearMonthDay(year: currentDate.year,
																 month: currentDate.month,
																 day: currentDate.day,
																 amount: i - 1)

			var frame = scrollView.bounds
			frame.size.width = kSubViewWidth
			subVC!.view.frame = frame
			
			// 스크롤뷰에 새로 추가
			scrollView.addSubview(subVC!.view)
			arrSubCell.append(subVC!.view)
			arrSubCheild.append(subVC!)
		}
		
		let nWidth: CGFloat = kSubViewWidth * CGFloat(arrSubCell.count)
		scrollView.contentSize = CGSize(width: nWidth, height: scrollView.bounds.height)
		
		// 서브셀 위치 재설정
		reposSubCell()
		
		// 스크롤뷰 센터 이동
		self.scrollView.setContentOffset(CGPoint(x: self.kSubViewWidth - scrollView.contentInset.left, y: 0), animated: false)
    }
    
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		// 서브셀 위치 재설정
		reposSubCell()
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // 화면 갱신
    func updateScreen() {
        // 선택한 날짜가 오늘날짜와 동일한 경우
        if CalendarManager.getTodayIndex() == CalendarManager.curSelectedDay {
            self.lbTitle.text = "Today"
        }
        else {
            // 선택 날짜 초기화
            let YYYYMMDD: String = "\(CalendarManager.curSelectedDay)"
            let year: Int = Int(YYYYMMDD.left(4))!
            let month: Int = Int(YYYYMMDD.mid(4, amount: 2))!
            let day: Int = Int(YYYYMMDD.right(2))!
            
            self.lbTitle.text = String.init(format: "%d. %02d. %02d", year, month, day)
        }
    }

    // MARK: - Action
    // 달력 팝업
    @IBAction func onCalendarClick(_ sender: UIButton) {

        let popupVC = CalendarPopup.calendarPopup()
        popupVC.addActionConfirmClick { (year, month, day) in
			// 음식리스트 갱신
			for i in 0..<self.arrSubCell.count {
				let vSubCell = self.arrSubCell[i]
				if let subVC: FoodListViewController = self.getSelectedViewController(vSubCell) {
					subVC.currentDate =  CalendarManager.getYearMonthDay(year: year, month: month, day: day, amount: i - 1)
					subVC.updateScreen()
				}
			}
			
            // 화면 갱신
            self.updateScreen()
        }
    }
    
    // 음식 추가
    @IBAction func onFoodAddClick(_ sender: UIButton) {
        if let storyboard = AppDelegate.sharedNamedStroyBoard("Sama73") as? UIStoryboard {
            
            let foodAddVC: FoodAddViewController = storyboard.instantiateViewController(withIdentifier: "FoodAddViewController") as! FoodAddViewController
            self.present(foodAddVC, animated: true, completion: nil)
        }
    }
	
	@IBAction func onTabbarShowClick(_ sender: UIButton) {
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showTabbar"),
										object: nil,
										userInfo: ["isHidden": false, "isAnimation": true])
	}
	
	@IBAction func onTabbarHideClick(_ sender: UIButton) {
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showTabbar"),
										object: nil,
										userInfo: ["isHidden": true, "isAnimation": true])
	}
	
	@IBAction func onTabbarShow2Click(_ sender: UIButton) {
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showTabbar"),
										object: nil,
										userInfo: ["isHidden": false, "isAnimation": false])
	}
	
	@IBAction func onTabbarHide2Click(_ sender: UIButton) {
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showTabbar"),
										object: nil,
										userInfo: ["isHidden": true, "isAnimation": false])
	}
	
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.vWaveGage!.updateFrame(value: sender.value)
    }

}


extension CalorieMainViewController: UIScrollViewDelegate {
	
	// 선택한 뷰로 VC찾아오기
	func getSelectedViewController(_ view: UIView) -> FoodListViewController? {
		for subVC in arrSubCheild {
			if subVC.view == view {
				return subVC
			}
		}
		
		return nil
	}
	
	// 서브셀 위치 재설정
	// move = -1 : 이전 페이지 이동
	// move = 0 : 현재 페이지
	// move = 1 : 다음 페이지 이동
	func reposSubCell(move: Int = 0) {
		
		// 도출 개시의 x, y 위치
		var px: CGFloat = 0.0
		
		for vSubCell in arrSubCell {
			// 서브셀 위치 재설정
			var viewFrame = vSubCell.frame
			viewFrame.origin.x = px
			viewFrame.size.width = kSubViewWidth
			vSubCell.frame = viewFrame
			px += kSubViewWidth
			
			print("viewFrame=\(viewFrame)")
		}
		
		// 스크롤 옵셋값 수정
		if move == 1 {
			scrollView.contentOffset.x -= kSubViewWidth
		}
		else if move == -1 {
			scrollView.contentOffset.x += kSubViewWidth
		}
	}
	
	// 이전 페이지 이동시 처리
	func goPrevPage() {
		// 마지막뷰를 첫번째로 이동
		let subCellLast = arrSubCell.popLast()
		let subCellCenter = arrSubCell.first
		arrSubCell.insert(subCellLast!, at: 0)
		
		// 새로 추가되는 셀 날짜 설정
		let subLastVC: FoodListViewController? = getSelectedViewController(subCellLast!)
		let subCenterVC: FoodListViewController? = getSelectedViewController(subCellCenter!)
		if let subLastVC = subLastVC, let subCenterVC = subCenterVC {
			let curDate = subCenterVC.currentDate!
			subLastVC.currentDate =  CalendarManager.getYearMonthDay(year: curDate.year, month: curDate.month, day: curDate.day, amount: -1)
			subLastVC.updateScreen()
		}
		
		// 서브셀 위치 재설정
		reposSubCell(move: -1)
	}
	
	// 다음 페이지 이동시 처리
	func goNextPage() {
		// 맨처음뷰를 첫번째로 이동
		let subCellFirst = arrSubCell.removeFirst()
		let subCellCenter = arrSubCell.first
		arrSubCell.append(subCellFirst)
		
		// 새로 추가되는 셀 날짜 설정
		let subFirstVC: FoodListViewController? = getSelectedViewController(subCellFirst)
		let subCenterVC: FoodListViewController? = getSelectedViewController(subCellCenter!)
		if let subFirstVC = subFirstVC, let subCenterVC = subCenterVC {
			let curDate = subCenterVC.currentDate!
			subFirstVC.currentDate =  CalendarManager.getYearMonthDay(year: curDate.year, month: curDate.month, day: curDate.day, amount: 2)
			subFirstVC.updateScreen()
		}
		
		// 서브셀 위치 재설정
		reposSubCell(move: 1)
	}
	
	// 스크롤 정보 갱신
	func updateScrollView(_ scrollView: UIScrollView) {
		
		let gap: CGFloat = scrollView.contentOffset.x - oldContentOffsetX
		if gap < 0 {
			// 이전 페이지 이동시 처리
			goPrevPage()
		}
		else if gap > 0 {
			// 다음 페이지 이동시 처리
			goNextPage()
		}
		else {
			return
		}
		
		UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
			scrollView.contentOffset = CGPoint(x: self.kSubViewWidth - scrollView.contentInset.left, y: 0)
		}) { finished in
			let subCenterVC: FoodListViewController? = self.getSelectedViewController(self.arrSubCell[1])
			if let subCenterVC = subCenterVC {
				CalendarManager.curSelectedDay = subCenterVC.currentDate!.year * 10000 + subCenterVC.currentDate!.month * 100 + subCenterVC.currentDate!.day
				// 화면 갱신
				self.updateScreen()
			}
		}
	}

	// 셀뷰 Y위치값 갱신
	func updateCellPosY(_ scrollView: UIScrollView) {
		// 서브셀 위치 재설정
		let ratio: CGFloat = 90.0 / maxCellVerticalGap
		
		// 화면 센터 거리에 따라서 셀 높이 조절
		for vSubCell in arrSubCell {
			let p = self.view.convert(self.view.center, from: vSubCell)
			var posY: CGFloat = (p.x - scrollView.center.x - scrollView.contentInset.left) / 24.0
			if posY < 0 {
				posY *= -1
			}
			
			// 13보다 크면
			if posY > maxCellVerticalGap {
				posY = maxCellVerticalGap
			}
			
			let mulValue: CGFloat = ratio * posY * CGFloat(sinus) * maxCellVerticalGap
			var frame = vSubCell.frame
			frame.origin.y = mulValue
			vSubCell.frame = frame
		}
	}

	// 2. 스크롤뷰가 스크롤 된 후에 실행된다.
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		
		// 셀뷰 Y위치값 갱신
		updateCellPosY(scrollView)
	}

	// 스크롤 뷰에서 내용 스크롤을 시작할 시점을 대리인에게 알립니다.
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		print("scrollViewWillBeginDragging:")
		
		oldContentOffsetX = scrollView.contentOffset.x
	}
	
	// 드래그가 스크롤 뷰에서 끝났을 때 대리자에게 알립니다.
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		print("scrollViewDidEndDragging:willDecelerate:")
		
		// 감속처리가 없을 경우에만 처리되도록...
		if decelerate == false {
			// 무한스크롤뷰 일때
			let tabIndex: Int = Int((scrollView.contentOffset.x + scrollView.center.x) / kSubViewWidth)
			// Prev Move
			if tabIndex == 0 {
				// 이전 페이지 이동시 처리
				goPrevPage()
			}
				// Next Move
			else if tabIndex == 2 {
				// 다음 페이지 이동시 처리
				goNextPage()
			}
			
			UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
				scrollView.contentOffset = CGPoint(x: self.kSubViewWidth - scrollView.contentInset.left, y: 0)
			}) { finished in
				let subCenterVC: FoodListViewController? = self.getSelectedViewController(self.arrSubCell[1])
				if let subCenterVC = subCenterVC {
					CalendarManager.curSelectedDay = subCenterVC.currentDate!.year * 10000 + subCenterVC.currentDate!.month * 100 + subCenterVC.currentDate!.day
					// 화면 갱신
					self.updateScreen()
				}
			}
		}
	}
	
	// 스크롤뷰가 Touch-up 이벤트를 받아 스크롤 속도가 줄어들때 실행된다.
	func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		print("scrollViewWillBeginDecelerating")
		
	}
	
	// 스크롤 애니메이션의 감속 효과가 종료된 후에 실행된다.
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		print("scrollViewDidEndDecelerating")
		
	}
	
	// (현재 못씀)
	func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
		print("scrollViewDidEndScrollingAnimation")
		
	}

	// scrollView.scrollsToTop = YES 설정이 되어 있어야 아래 이벤트를 받을수 있다.
	// 스크롤뷰가 가장 위쪽으로 스크롤 되기 전에 실행된다. NO를 리턴할 경우 위쪽으로 스크롤되지 않도록 한다.
	//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
	//{
	//    NSLog(@"scrollViewShouldScrollToTop");
	//    return YES;
	//}
	
	// 스크롤뷰가 가장 위쪽으로 스크롤 된 후에 실행된다.
	//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
	//{
	//    NSLog(@"scrollViewDidScrollToTop");
	//}
	
	// 사용자가 콘텐츠 스크롤을 마쳤을 때 대리인에게 알립니다.
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		print("scrollViewWillEndDragging:withVelocity:targetContentOffset:")
		if velocity.x != 0 {
			targetContentOffset.pointee = scrollView.contentOffset
			
			// 스크롤 정보 갱신
			updateScrollView(scrollView)
		}
	}
}
