//
//  SetlistTableViewController.swift
//  setlists2
//
//  Created by Chris McQueen on 7/26/18.
//  Copyright © 2018 Chris McQueen. All rights reserved.
//

import UIKit

class SetlistTableViewController: UITableViewController {
    
    var setlists = [Setlist]()
    
    func loadSampleSetlists() {
        setlists = [Setlist(name: "Test", key: "Ab")] as! [Setlist]
    }
    
    func saveSetlists() {
        let isSaved = NSKeyedArchiver.archiveRootObject(setlists, toFile: Setlist.ArchiveURL.path)
    if !isSaved {
            print("Failed to save setlists...")
        }
    }
    
    func loadSetlists() -> [Setlist]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Setlist.ArchiveURL.path) as? [Setlist]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load saved items
        if let savedSetlists = loadSetlists() {
            setlists += savedSetlists
        }
        
        // initialize
       // loadSampleSetlists()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return setlists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SetlistTableViewCell", for: indexPath) as! SetlistTableViewCell

        // Configure the cell...
        
        let setlist = setlists[indexPath.row]
        cell.setlistLabel.text = setlist.name
        cell.songKey.text = setlist.key

        return cell
    }
    
    @IBAction func unwindToList(sender: UIStoryboardSegue) {
        let srcViewCon = sender.source as? ViewController
        let setlist = srcViewCon?.setlist
        if (srcViewCon != nil && setlist?.name != "") {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing setlist
                setlists[selectedIndexPath.row] = setlist!
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
            // Add a new setlist
            let newIndexPath = IndexPath(row: setlists.count, section: 0)
            setlists.append(setlist!)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            saveSetlists()
        }
    }
    
    @IBAction func addBreak(_ sender: UIBarButtonItem) {
        let name = "————————————"
        let key = ""
        let setlist = Setlist(name: name, key: key)
        let newIndexPath = IndexPath(row: setlists.count, section: 0)
        setlists.append(setlist!)
        tableView.insertRows(at: [newIndexPath], with: .bottom)
        saveSetlists()
    }
    
    @IBAction func printSetlist(_ sender: UIBarButtonItem) {
        var printout = ""
        for (index, song) in setlists.enumerated() {
            printout += song.name
            if song.key != "" {
                printout += " (" + song.key + ")"
            }
            if index < (setlists.count - 1) {
                printout += "\r\n"
            }
        }
        UIPasteboard.general.string = printout
        
        // the alert view
        let alert = UIAlertController(title: "", message: "Copied to the clipboard", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            setlists.remove(at: indexPath.row)
            saveSetlists()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedObject = self.setlists[fromIndexPath.row]
        setlists.remove(at: fromIndexPath.row)
        setlists.insert(movedObject, at: to.row)
        saveSetlists()
    }
    

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
        if segue.identifier == "ShowDetail" {
            let detailVC = segue.destination as! ViewController
            
            // Get the cell that generated this segue
            if let selectedCell = sender as? SetlistTableViewCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedSetlist = setlists[indexPath.row]
                detailVC.setlist = selectedSetlist
            }
        }
        else if segue.identifier == "AddSetlist" {
            
        }
    }
    

}
