//
//  MonitoringTableViewController.swift
//  Vision
//
//  Created by Gilles Dubois on 11/10/2017.
//  Copyright © 2017 Gilles Dubois. All rights reserved.
//

import UIKit
import os.log
import PlainPing
import Alamofire

class MonitoringTableViewController: UITableViewController {
    
    //MARK: Properties
    var mons = [Monitoring]()
    
    //MARK: Actions
    @IBAction func unwindToMonitoringList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MonitoringViewController, let monitoring = sourceViewController.monitoring {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing monitoring.
                mons[selectedIndexPath.row] = monitoring
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else{
                // Add a new monitoring.
                let newIndexPath = IndexPath(row: mons.count, section: 0)
                
                mons.append(monitoring)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new monitoring.", log: OSLog.default, type: .debug)
        case "EditItem":
            guard let monitoringDetailViewController = segue.destination as? MonitoringViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMonitoringCell = sender as? MonitoringTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMonitoringCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMonitoring = mons[indexPath.row]
            monitoringDetailViewController.monitoring = selectedMonitoring
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
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
        
        // Fetches the appropriate monitoring for the data source layout.
        let mon = mons[indexPath.row]
        
        cell.serverUrl.text = mon.serverUrl
        cell.serverName.text = mon.name
        
        // Check server connexion
        self.checkServerStatus(serverUrl: mon.serverUrl, isIcmp: mon.isIcmp, isHttp: mon.isHttp, statusImage: cell.monitoringStatus)

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            mons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    //MARK: Private Methods
    private func loadSamples() {
        
        guard let mon1 = Monitoring(name: "Google", serverUrl: "www.google.fr", isIcmp: false, isHttp: true, refreshRate : 60) else {
            fatalError("Unable to instantiate mon1")
        }
        
        guard let mon2 = Monitoring(name: "Yolo", serverUrl: "www.yolo.fr", isIcmp: true, isHttp: true, refreshRate : 60) else {
            fatalError("Unable to instantiate mon2")
        }
        
        guard let mon3 = Monitoring(name: "LiveBox", serverUrl: "192.168.1.1", isIcmp: true, isHttp: false, refreshRate : 20) else {
            fatalError("Unable to instantiate mon3")
        }
        
        guard let mon4 = Monitoring(name: "Valentin Network", serverUrl: "network.valentin-deville.eu", isIcmp: true, isHttp: false, refreshRate : 5) else {
            fatalError("Unable to instantiate mon4")
        }
        
        guard let mon5 = Monitoring(name: "Wolo Online", serverUrl: "wolo-online.fr", isIcmp: false, isHttp: true, refreshRate : 10) else {
            fatalError("Unable to instantiate mon5")
        }

        guard let mon6 = Monitoring(name: "Wala Online", serverUrl: "wala-online.fr", isIcmp: false, isHttp: true, refreshRate : 15) else {
            fatalError("Unable to instantiate mon6")
        }
        
        mons += [mon1, mon2, mon3, mon4, mon5, mon6]
        
    }
    
    private func checkServerStatus(serverUrl: String, isIcmp: Bool, isHttp: Bool, statusImage: MonitoringStatus) -> Void {
        
        if(isIcmp){
            // Test on the fly by pinging the address set
            PlainPing.ping( serverUrl, withTimeout: 1.0, completionBlock: { (timeElapsed:Double?, error:Error?) in
                if timeElapsed != nil {
                    statusImage.image = #imageLiteral(resourceName: "Up")
                }
                
                if let error = error {
                    print("error: \(error.localizedDescription)")
                    statusImage.image = #imageLiteral(resourceName: "Down")
                }
            })
        }
        
        if(isHttp){
            
            var srvUrl : String =  serverUrl
            
            // add http // https if not in the original string
            if( (!(srvUrl.hasPrefix("http://"))) && (!(srvUrl.hasPrefix("https://"))) ){
                srvUrl = "\("https://" + srvUrl)"
                debugPrint(srvUrl)
            }
            
            // Test for http connect
            Alamofire.request(srvUrl)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["text/html"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                        statusImage.image = #imageLiteral(resourceName: "Up")
                    case .failure(let error):
                        print(error)
                        statusImage.image = #imageLiteral(resourceName: "Down")
                    }
            }
        }
        
    }
}
