//
//  MonitoringViewController.swift
//  Vision
//
//  Created by Gilles Dubois on 10/10/2017.
//  Copyright © 2017 Gilles Dubois. All rights reserved.
//

import UIKit

class MonitoringViewController: UIViewController {
    
    // UI Properties
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var serverAddress: UITextField!
    @IBOutlet weak var icmpSwitch: UISwitch!
    @IBOutlet weak var httpSwitch: UISwitch!
    @IBOutlet weak var refreshRateSlider: UISlider!
    @IBOutlet weak var refreshLabel: UILabel!
    
    // Below UI properties are only shown on edit ( moniroting already set )
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

