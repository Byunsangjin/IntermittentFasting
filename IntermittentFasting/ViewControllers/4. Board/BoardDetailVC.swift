//
//  BoardDetailVC.swift
//  IntermittentFasting
//
//  Created by 박종현 on 25/05/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

import UIKit

class BoardDetailVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}

extension BoardDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let number = 4
        return number
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if section == 0 {
            numberOfRows = 2
        }else if section == 1 {
            // 사진
            numberOfRows = 1
        }else if section == 2 {
            numberOfRows = 1
        }else if section == 3 {
            // 댓글
            numberOfRows = 1
        }else {
            
        }
        
        return numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let cell:BoardDetailCell!
        if section == 0 {
            if row == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "BoardDetailTitle") as? BoardDetailCell
            }else if row == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "BoardDetailContent") as? BoardDetailCell
            }else {
                cell = UITableViewCell.init() as? BoardDetailCell
            }
        }else if section == 1 {
            // 사진
            cell = tableView.dequeueReusableCell(withIdentifier: "BoardDetailPhoto") as? BoardDetailCell
        }else if section == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "BoardDetailLike") as? BoardDetailCell
        }else if section == 3 {
            // 댓글
            cell = tableView.dequeueReusableCell(withIdentifier: "BoardDetailComment") as? BoardDetailCell
        }else {
            cell = UITableViewCell.init() as? BoardDetailCell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = 0
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 {
            if row == 0 {
                height = 80
            }else if row == 1 {
                height = 90
            }
        }else if section == 1 {
            // 사진
            height = 222
        }else if section == 2 {
            height = 118
        }else if section == 3 {
            // 댓글
            height = 62
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
