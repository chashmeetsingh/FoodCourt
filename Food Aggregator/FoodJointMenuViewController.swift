//
//  FoodJointMenuViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class FoodJointMenuViewController: UITableViewController {

    var tableViewData = [cellData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Food Joint Name"
        
        self.view.backgroundColor = .white
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self

        tableViewData = [cellData(opened: false, title: "Title1", sectionData: ["asda", "asd", "asd"]),
                cellData(opened: true, title: "Title2", sectionData: ["asda", "asd", "asd"]),
                cellData(opened: false, title: "Title3", sectionData: ["asda", "asd", "asd"])]

        tableView.register(FoodClassCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ExpandedCell.self, forCellReuseIdentifier: "expandedCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened {
            return tableViewData[section].sectionData.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoodClassCell
            cell.textLabel?.text = tableViewData[indexPath.section].title
            cell.backgroundColor = .black
            cell.textLabel?.textColor = .white
            if tableViewData[indexPath.section].opened {
                cell.upDownButton.setImage(UIImage(named: "up_arrow"), for: .normal)
            } else {
                cell.upDownButton.setImage(UIImage(named: "down_arrow"), for: .normal)
            }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "expandedCell", for: indexPath) as! ExpandedCell
            cell.titleLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row]
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewData[indexPath.section].opened {
            tableViewData[indexPath.section].opened = false
            handleOpening(indexPath: indexPath, upOrDown: "up_arrow")
        } else {
            tableViewData[indexPath.section].opened = true
            handleOpening(indexPath: indexPath, upOrDown: "down_arrow")
        }
    }
    
    @objc func handleOpening(indexPath: IndexPath, upOrDown: String) {
        let sections = IndexSet(integer: indexPath.section)
        let cell = tableView.cellForRow(at: indexPath) as! FoodClassCell
        cell.upDownButton.setImage(UIImage(named: upOrDown), for: .normal)
        tableView.reloadSections(sections, with: .none)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}

class FoodClassCell: BaseTableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let upDownButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleLabel)
        addSubview(upDownButton)
        addConstraintsWithFormat(format: "H:|-24-[v0][v1]-8-|", views: titleLabel, upDownButton)
        addConstraintsWithFormat(format: "V:|[v0]|", views: titleLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: upDownButton)
    }
    
}

class ExpandedCell: BaseTableViewCell {
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleLabel)
        addSubview(stepper)
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: titleLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: stepper)
        
        addConstraintsWithFormat(format: "H:|-24-[v0][v1(100)]-8-|", views: titleLabel, stepper)
        
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let stepper: GMStepper = {
        let stepper = GMStepper()
        stepper.labelFont = UIFont.systemFont(ofSize: 16)
        stepper.autorepeat = false
        return stepper
    }()
    
}
