//
//  ProfileTableViewController.swift
//  Project_224
//
//

import UIKit
import os

/// profileTableViewController class 
class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var cancelToEntry: UIBarButtonItem!
    
    /// declaring variable of items holding an array of Profile class.
    var items = [Profile]()
	/// setting cellIdentifier to the ProfileTableViewCell.
    let cellIdentifier = "ProfileTableViewCell"
	/// having a receiveText of an empty string.
    var receiveText = " "
	/// Function to load items
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let restored = loadItems() {
            items += restored
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    /// Table view function for the cell to placing each item into a the row of the cell.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProfileTableViewCell else {
            fatalError("Selected cell is not of type \(cellIdentifier)")
        }
        
        let item = items[indexPath.row]
        cell.profileImageView.image = item.image
        cell.nameLabel.text = item.name
        /// Configure the cell
        print(type(of: item.name))
        /// cell.name.text = NSString(format: "%@",item.name) as String
        print(item.image)
        print(type(of: item.image))
        
        return cell
    }
    
    /// Unwind function to the ProfileList when user click save button
    @IBAction func unwindToProfileList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ProfileViewController, let item = sourceViewController.profile {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                /// Edit
                items[selectedIndexPath.row] = item
                tableView.reloadRows(at:[selectedIndexPath], with:.none)
                print("selected")
                print(item)
            } else {
                /// Add a new profile.
                let newIndexPath = IndexPath(row: items.count, section: 0)
                
                items.append(item)
                print(item)
                print("new")
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                saveItems() //calling save items
            }
        }
    }
    
	/// error handling if item didn't placed in the right order.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender:sender)
        if segue.identifier == "ShowItem"{
            guard let detailViewController = segue.destination as? ProfileViewController else {
                fatalError("Unexpected destination\(segue.destination)")
                
            }
            guard let selectedTableViewCell = sender as? ProfileTableViewCell else{
                fatalError("Unexpected destination \(String(describing:sender))")
                
            }
            guard let indexPath = tableView.indexPath(for: selectedTableViewCell) else{
                fatalError("Unexpected index path for\(selectedTableViewCell)")
                
            }
            detailViewController.profile = items[indexPath.row]
        }
    }
    
    /// Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            /// Delete the row from the data source
            items.remove(at:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveItems()
        } else if editingStyle == .insert {
            /// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    /// save each item function
    func saveItems(){
        if !NSKeyedArchiver.archiveRootObject(items, toFile: Profile.archiveURL.path){
            os_log("Cannot save in %@", log: OSLog.default, type:.debug, Profile.archiveURL.path)
        }
    }
    
    /// load items function
    func loadItems() -> [Profile]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Profile.archiveURL.path) as? [Profile]  
    }
}
