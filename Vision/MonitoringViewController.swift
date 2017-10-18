//
//  MonitoringViewController.swift
//  Vision
//
//  Created by Gilles Dubois on 10/10/2017.
//  Copyright © 2017 Gilles Dubois. All rights reserved.
//

import UIKit

/*
 This value is either passed by `MonitoringTableViewController`
 */
var monitoring: Monitoring?

class MonitoringViewController: UIViewController, UITextFieldDelegate{
    
    // MARK : UI Properties
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var serverAddress: UITextField!
    @IBOutlet weak var icmpSwitch: UISwitch!
    @IBOutlet weak var httpSwitch: UISwitch!
    @IBOutlet weak var refreshRateSlider: UISlider!
    @IBOutlet weak var refreshLabel: UILabel!
    
    // Below UI properties are only shown on edit ( moniroting already set )
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
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
        
        // Disable save button by default
        saveButton.isEnabled = false
        
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


}

