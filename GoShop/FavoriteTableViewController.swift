//
//  FavoriteTableViewController.swift
//  GoShop
//
//  Created by Yen Hung Cheng on 2023/1/27.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    
    let userDefault = UserDefaults.standard
    
    let AllProdict = ["Red Apple", "Organic Bananas", "Pineapple", "Small Hass Avocados", "Diet Coke", "Sprite Can", "Orenge Juice", "Apple & Grape Juice", "Loin Chops Thick", "Chicken Drumsticks", "Beef Chuck Eye Steak", "Atlantic Salmon"]
    
    
    var DisplayProdictBool: [Bool] = []
    var counts = 0
    var DisplayProdicts: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        // 接收通知
        NotificationCenter.default.addObserver(self, selector: #selector(updatefavorite(noti: )), name: AllNotification.favoritupdate, object: nil)
        
    }
    
    func updateUI() {
        // 讀取存在 userDefault 的資料
        // 並同步到 DisplayProdict
        DisplayProdictBool = userDefault.array(forKey: "favorite") as! [Bool]
        
        // 計算 true 的數量
        for i in DisplayProdictBool where i == true {
            counts += 1
        }
        
        // 找出對應為 true 的資料，並加入到顯示的 Array 中
        for i in 0...AllProdict.count - 1 where DisplayProdictBool[i] == true {
            DisplayProdicts.append(AllProdict[i])

        }
    }
    
    
    @objc func updatefavorite(noti: Notification) {
        // 刪除舊的資料
        counts = 0
        DisplayProdicts = []
        updateUI()
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return counts
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        content.image = UIImage(named: "\(DisplayProdicts[indexPath.row])")
        content.text = "\(DisplayProdicts[indexPath.row])"
        cell.contentConfiguration = content
        
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
