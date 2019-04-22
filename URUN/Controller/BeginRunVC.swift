//
//  FirstViewController.swift
//  URUN
//
//  Created by Jose M Arguinzzones on 2019-03-09.
//  Copyright © 2019 Jose M Arguinzzones. All rights reserved.
//

import UIKit
import MapKit

class BeginRunVC: LocationVC {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var lastRunCloseBtn: UIButton!
    @IBOutlet var paceLbl: UILabel!
    @IBOutlet var distanceLbl: UILabel!
    @IBOutlet var durationLbl: UILabel!
    
    @IBOutlet var lastRunBGView: UIView!
    @IBOutlet var lasRunStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        checkLocationAuthStatus()
        mapView.delegate = self
        print("here are my runs: \(String(describing: Run.getAllRuns()))")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.startUpdatingLocation()
        getLastRun()
    }
    override func viewDidAppear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    func getLastRun() {
        guard let lastRun = Run.getAllRuns()?.first else {
            lasRunStack.isHidden = true
            lastRunBGView.isHidden = true
            lastRunCloseBtn.isHidden = true
            return
            
        }
        lasRunStack.isHidden = false
        lastRunBGView.isHidden = false
        lastRunCloseBtn.isHidden = false
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        durationLbl.text = lastRun.duration.formatTimeDurationToString()
        
    }

    @IBAction func lastRunCloseBtnPressed(_ sender: Any) {
        lasRunStack.isHidden = true
        lastRunBGView.isHidden = true
        lastRunCloseBtn.isHidden = true
        
    }
    @IBAction func locationCenterBtnPressed(_ sender: Any) {
    }
    
}
extension BeginRunVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
       
    }
}

