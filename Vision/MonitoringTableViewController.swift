//
//  MonitoringTableViewController.swift
//  Vision
//
//  Created by Gilles Dubois on 11/10/2017.
//  Copyright © 2017 Gilles Dubois. All rights reserved.
//

import UIKit

class MonitoringTableViewController: UITableViewController {
    
    //MARK: Properties
    var mons = [Monitoring]()
    
    //MARK: Private Methods
    private func loadSamples() {
        
        guard let mon1 = Monitoring(name: "Monitor 1", serverUrl: "192.168.1.100", isIcmp: true, isHttp: false, refreshRate : 40) else {
            fatalError("Unable to instantiate mon1")
        }
        
        guard let mon2 = Monitoring(name: "Monitor 2", serverUrl: "192.168.1.10", isIcmp: true, isHttp: false, refreshRate : 50) else {
            fatalError("Unable to instantiate mon2")
        }
        
        guard let mon3 = Monitoring(name: "Monitor 3", serverUrl: "192.168.1.1", isIcmp: true, isHttp: false, refreshRate : 30) else {
            fatalError("Unable to instantiate mon3")
        }
        
        mons += [mon1, mon2, mon3]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSamples()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MonitoringTableViewCell"
        
        // Configure the cell...
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MonitoringTableViewCell  else {
            fatalError("The dequeued cell is not an instance of Monitoring Table View Cell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let mon = mons[indexPath.row]
        
        cell.serverUrl.text = mon.serverUrl
        cell.serverName.text = mon.name
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
