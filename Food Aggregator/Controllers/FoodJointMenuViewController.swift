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
    var restaurant: Restaurant!
    
    var appDelegate:  AppDelegate {
        get {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    
    var cartItemsCount: String {
        get {
            var count: Int  = 0
            if let currentFoodCourtCart = appDelegate.cartItems[restaurant.fcId] {
                for item in currentFoodCourtCart {
                    count += Int(item.value)!
                }
            }
            return "\(count)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Food Menu"
        
        self.view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)

        tableView.register(FoodClassCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ExpandedCell.self, forCellReuseIdentifier: "expandedCell")
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        getFoodMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(appDelegate.cartItems)
        setCartIconBadge(cartItemsCount)
        cartUpdatedFromDidAppear()
    }
    
    func setCartIconBadge(_ value: String = "") {
        let cartButton = UIButton()
        cartButton.setImage(UIImage(named: "cart"), for: .normal)
        cartButton.addTarget(self, action: #selector(openCart), for: .touchUpInside)
        let item = BBBadgeBarButtonItem(customUIButton: cartButton)
        item!.badgeValue = cartItemsCount
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func openCart() {
        let vc = CartViewController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getFoodMenu() {
        
        let params = [
            Client.Keys.RestaurantID: restaurant.id
        ]
        
        self.tableView.makeToastActivity(.center)
        Client.sharedInstance.getFoodMenu(params as [String : AnyObject]) { (foodMenu, success, message) in
            DispatchQueue.main.async {
                self.tableView.hideToastActivity()
                if success {
                    if let menuItems = foodMenu {
                        self.foodMenuData = []
                        for item in menuItems {
                            self.foodMenuData.append(CellData(opened: true, title: item.name, sectionData: item.foodItems))
                            for foodItem in item.foodItems {
                                self.appDelegate.items["\(foodItem.id)"] = foodItem
                            }
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
        }
        return 1
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
            let item = foodMenuData[indexPath.section].sectionData[indexPath.item - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: "expandedCell", for: indexPath) as! ExpandedCell
            cell.titleLabel.text = item.name
            cell.priceLabel.text = "$\(item.cost)"
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
            cell.stepper.addTarget(self, action: #selector(cartUpdated), for: .valueChanged)
            if let restCart = appDelegate.cartItems[restaurant.fcId], let count = restCart["\(item.id)"] {
                cell.stepper.value = Double(count)!
            }
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
        if let cell = tableView.cellForRow(at: indexPath) as? FoodClassCell {
            cell.upDownButton.setImage(UIImage(named: upOrDown), for: .normal)
            tableView.reloadSections(sections, with: .none)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return 44
        } else {
            return 56
        }
    }
    
    @objc func cartUpdated() {
        var cartData = [String : String]()
        if let data = appDelegate.cartItems[restaurant.fcId] {
            cartData = data
        }
        for section in 0..<foodMenuData.count {
            let rows = tableView.numberOfRows(inSection: section)
            for row in 0..<rows {
                if let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) as? ExpandedCell {
                    let item = foodMenuData[section].sectionData[row - 1]
                    if Int(cell.stepper.value) > 0 {
                        cartData["\(item.id)"] = "\(Int(cell.stepper.value))"
                    } else {
                        cartData.removeValue(forKey: "\(item.id)")
                    }
                }
            }
        }

        appDelegate.cartItems[restaurant.fcId] = cartData
        setCartIconBadge(cartItemsCount)
    }
    
    @objc func cartUpdatedFromDidAppear() {
        var cartData = [String : String]()
        if let data = appDelegate.cartItems[restaurant.fcId] {
            cartData = data
            
            for section in 0..<foodMenuData.count {
                let rows = tableView.numberOfRows(inSection: section)
                for row in 0..<rows {
                    if let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) as? ExpandedCell {
                        let item = foodMenuData[section].sectionData[row - 1]
                        if let data = cartData["\(item.id)"], Int(data)! > 0 {
                            cell.stepper.value = Double(data)!
                        } else {
                            cell.stepper.value = 0
                        }
                    }
                }
            }
            
            setCartIconBadge(cartItemsCount)
        }
    }

}
