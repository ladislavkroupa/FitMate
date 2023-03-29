//
//  SwapTableViewController.swift
//  FitMate
//
//  Created by Ladislav Kroupa on 17.03.2023.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework


class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellSwipeIdentifier, for: indexPath) as! SwipeTableViewCell

        cell.delegate = self
        
        cell.textLabel?.font = UIFont(name: "DIN Condensed", size: 20)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            self.deleteModel(at: indexPath)
        }
        
        let editAction = SwipeAction(style: .default, title: "Edit") { editAction, indexPath in
            self.editModel(at: indexPath)
        }
        
        deleteAction.backgroundColor = FlatRed()
        deleteAction.image = UIImage(named: "delete-icon")
        editAction.backgroundColor = .systemBlue
        editAction.image = UIImage(named: "pen-icon")
        
        
        
        return [deleteAction, editAction]
        
    }
    
    func deleteModel(at indexPath: IndexPath) {
        
    }
    
    func editModel(at indexPath: IndexPath){
        //Edit model
        
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
