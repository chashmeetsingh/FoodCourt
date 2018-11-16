//
//  FoodJointMenuViewController.swift
//  Food Aggregator
//
//  Created by Chashmeet on 12/10/18.
//  Copyright © 2018 Chashmeet Singh. All rights reserved.
//

import UIKit
import BBBadgeBarButtonItem

struct CellData {
    var opened = Bool()
    var title = String()
    var sectionData = [FoodItem]()
}

class FoodJointMenuViewController: UITableViewController {

    var foodMenuData = [CellData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Food Menu"
        
        self.view.backgroundColor = .white
        
//        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self

//        tableViewData = [cellData(opened: true, title: "Burgers", sectionData: ["Mc Chicken", "Junior Chicken", "Chilli Chicken"]),
//                cellData(opened: true, title: "Beverage", sectionData: ["Ice tea", "Coke"]),
//                cellData(opened: true, title: "Sides", sectionData: ["Fries", "Poutine", "Onion Rings"])]
        
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
        
        getFoodMenu()
        
    }
    
    @objc func openCart() {
        let vc = CartViewController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getFoodMenu() {
        
        let params = [
            Client.Keys.RestaurantName: "KFC"
        ]
        
        self.view.makeToastActivity(.center)
        Client.sharedInstance.getFoodMenu(params as [String : AnyObject]) { (foodMenu, success, message) in
            DispatchQueue.main.async {
                self.view.hideToastActivity()
                if success {
                    if let menuItems = foodMenu {
                        self.foodMenuData = []
                        for item in menuItems {
                            self.foodMenuData.append(CellData(opened: true, title: item.name, sectionData: item.foodItems))
                        }
                    }
                    self.tableView.reloadData()
                } else {
                    print(message ?? "error occured")
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return foodMenuData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if foodMenuData[section].opened {
            return foodMenuData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoodClassCell
            cell.textLabel?.text = foodMenuData[indexPath.section].title
            cell.backgroundColor = .white
            cell.textLabel?.textColor = .black
            if foodMenuData[indexPath.section].opened {
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
            cell.titleLabel.text = foodMenuData[indexPath.section].sectionData[indexPath.item - 1].name
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if foodMenuData[indexPath.section].opened {
            foodMenuData[indexPath.section].opened = false
            handleOpening(indexPath: indexPath, upOrDown: "up_arrow")
        } else {
            foodMenuData[indexPath.section].opened = true
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
