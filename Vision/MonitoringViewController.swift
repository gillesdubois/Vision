//
//  MonitoringViewController.swift
//  Vision
//
//  Created by Gilles Dubois on 10/10/2017.
//  Copyright © 2017 Gilles Dubois. All rights reserved.
//

import UIKit
import os.log
import PlainPing

class MonitoringViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate{
    
    /*
     This value is either passed by `MonitoringTableViewController`
     */
    var monitoring: Monitoring?
    
    // MARK : UI Properties
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var serverAddress: UITextField!
    @IBOutlet weak var icmpSwitch: UISwitch!
    @IBOutlet weak var httpSwitch: UISwitch!
    @IBOutlet weak var refreshRateSlider: UISlider!
    @IBOutlet weak var refreshLabel: UILabel!
    
    // Back and save buttons outlet
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK : Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Handle the text field’s user input through delegate callbacks.
        self.serverAddress.delegate = self
        self.name.delegate = self
        
        // Set up views if editing an existing Monitoring.
        if let monitoring = monitoring {
            navigationItem.title = monitoring.name
            name.text = monitoring.name
            serverAddress.text = monitoring.serverUrl
            icmpSwitch.isOn = monitoring.isIcmp
            httpSwitch.isOn = monitoring.isHttp
            refreshRateSlider.value = Float(monitoring.refreshRate)
            
            saveButton.isEnabled = true
        }else{
            // Disable save button by default on creation
            saveButton.isEnabled = false
        }
        
        // Set refresh label slider default value
        setRefreshLabelDepOnSlider()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark Action
    @IBAction func onRefreshSliderChange(_ sender: UISlider) {
        setRefreshLabelDepOnSlider()
    }
    
    // MARK : UITextFieldDelegate
    
    func textFieldDidEndEditing(_ name: UITextField) {
        if(self.name.text != "" && self.serverAddress.text != ""){
            // Enable object saving
            saveButton.isEnabled = true
        }else{
            // Disable object saving
            saveButton.isEnabled = false;
        }
    }
    
    func textFieldShouldReturn(_ name: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // MARK : Private functions
    private func setRefreshLabelDepOnSlider(){
        let currentValue = Int(self.refreshRateSlider.value)
        self.refreshLabel.text = "\(currentValue) Min(s)"
    }
    
    //MARK: Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        /*
         Var used :
            @IBOutlet weak var name: UITextField!
            @IBOutlet weak var serverAddress: UITextField!
            @IBOutlet weak var icmpSwitch: UISwitch!
            @IBOutlet weak var httpSwitch: UISwitch!
            @IBOutlet weak var refreshRateSlider: UISlider!
            @IBOutlet weak var refreshLabel: UILabel!
         */
        let name = self.name.text
        let srvAddress = self.serverAddress.text
        let icmpSwitch = self.icmpSwitch.isOn
        let httpSwitch = self.httpSwitch.isOn
        let refreshRateSlider = self.refreshRateSlider.value
        
        // Set the monitoring object to be passed to MonitoringTableViewController after the unwind segue.
        monitoring = Monitoring(name: name!, serverUrl: srvAddress!, isIcmp: icmpSwitch, isHttp: httpSwitch, refreshRate : Int(refreshRateSlider))
        
        
    }
    
    //MARK: ACTIONS
    @IBAction func CancelButtonAction(_ sender: Any) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMonitoringMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMonitoringMode {
            dismiss(animated: true, completion: nil)
        }else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }else {
            fatalError("The MonitoringViewController is not inside a navigation controller.")
        }
    }


}

