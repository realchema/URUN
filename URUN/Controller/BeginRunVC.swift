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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        checkLocationAuthStatus()
        mapView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self as? CLLocationManagerDelegate
        manager?.startUpdatingLocation()
    }
    override func viewDidAppear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
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

