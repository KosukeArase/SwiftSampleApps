//
//  MemoTableViewController.swift
//  MyMemoApp
//
//  Created by kosuke.arase on 2019/05/03.
//  Copyright © 2019 kosuke.arase. All rights reserved.
//

import UIKit

class MemoTableViewController: UITableViewController {
    
    let userDefaults = UserDefaults.standard
    var memos = [String]()
    
    @IBAction func unwindToMemoList(sender: UIStoryboardSegue) {
        guard let sourceVC = sender.source as? MemoViewController, let memo = sourceVC.memo else {
            return
        }
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.memos[selectedIndexPath.row] = memo
        } else {
            self.memos.append(memo)
        }
        self.userDefaults.set(self.memos, forKey: "memos")
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let memos = self.userDefaults.stringArray(forKey: "memos") {
            self.memos = memos
        } else {
            self.memos = ["m1", "m2", "m3"]
        }
//        if self.userDefaults.object(forKey: "memos") != nil {
//            self.memos = self.userDefaults.stringArray(forKey: "memos")!
//        } else {
//            self.memos = ["m1", "m2", "m3"]
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1  // self.memos.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.memos.count//[section].count
     }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath)

        cell.textLabel?.text = self.memos[indexPath.row]

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.memos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.userDefaults.set(self.memos, forKey: "memos")
        }
    }

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == "editMemo" {
            let memoVC = segue.destination as! MemoViewController
            memoVC.memo = self.memos[(self.tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
