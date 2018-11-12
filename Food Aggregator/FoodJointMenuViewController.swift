//
//  FoodJointMenuViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import BBBadgeBarButtonItem

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class FoodJointMenuViewController: UITableViewController {

    var tableViewData = [cellData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Food Menu"
        
        self.view.backgroundColor = .white
        
        tableView = UITableView()
//        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self

        tableViewData = [cellData(opened: false, title: "Burgers", sectionData: ["Mc Chicken", "Junior Chicken"]),
                cellData(opened: true, title: "Beverage", sectionData: ["Ice tea", "Coke"]),
                cellData(opened: false, title: "Sides", sectionData: ["Fries", "Poutine", "Onion Rings"])]
        
        tableView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)

        tableView.register(FoodClassCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ExpandedCell.self, forCellReuseIdentifier: "expandedCell")
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        let cartButton = UIButton()
        cartButton.setImage(UIImage(named: "cart"), for: .normal)
        cartButton.addTarget(self, action: #selector(openCart), for: .touchUpInside)
        let item = BBBadgeBarButtonItem(customUIButton: cartButton)
        item!.badgeValue = "5"
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func openCart() {
        let vc = CartViewController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(vc, animated: true)
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
            cell.backgroundColor = .white
            cell.textLabel?.textColor = .black
            if tableViewData[indexPath.section].opened {
                let image = UIImage(named: "up_arrow")?.withRenderingMode(.alwaysTemplate)
                cell.upDownButton.setImage(image, for: .normal)
                cell.upDownButton.imageView?.tintColor = .black
            } else {
                let image = UIImage(named: "down_arrow")?.withRenderingMode(.alwaysTemplate)
                cell.upDownButton.setImage(image, for: .normal)
                cell.upDownButton.imageView?.tintColor = .black
            }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "expandedCell", for: indexPath) as! ExpandedCell
            cell.titleLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row]
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
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
        stepper.maximumValue = 20
        stepper.buttonsBackgroundColor = UIColor(red: 139.0/255.0, green: 8.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        stepper.labelBackgroundColor = .white
        stepper.labelTextColor = .black
        stepper.limitHitAnimationColor = UIColor(red: 139.0/255.0, green: 8.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        return stepper
    }()
    
}
