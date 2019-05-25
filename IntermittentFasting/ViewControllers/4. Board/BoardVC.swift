//
//  BoardVC.swift
//  IntermittentFasting
//
//  Created by 박종현 on 24/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class BoardVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func pushBtn(_ sender: UIButton) {
        let tag = sender.tag
        let storyboard = UIStoryboard.init(name: "JhPark", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BoardDetailVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableView
extension BoardVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let number = 10
        return number
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = 4
        return numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let cell:BoardCell!
        if row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "BoardTitle") as? BoardCell
            cell.pushBtn.tag = section
        }else if row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "BoardContent") as? BoardCell
            cell.pushBtn.tag = section
        }else if row == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "BoardPhoto1") as? BoardCell
            cell.pushBtn.tag = section
        }else if row == 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: "BoardComment") as? BoardCell
        }else {
            cell = UITableViewCell.init() as? BoardCell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 0
        let row = indexPath.row
        if row == 0 {
            height = 80
        }else if row == 1 {
            height = UITableView.automaticDimension
        }else if row == 2 {
            height = 322
        }else if row == 3 {
            height = 60
        }else {
            
        }
        return height
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        view.backgroundColor = UIColor.init(hexString: "F3F3F3")
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
