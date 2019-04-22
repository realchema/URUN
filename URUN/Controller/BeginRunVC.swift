//
//  FirstViewController.swift
//  URUN
//
//  Created by Jose M Arguinzzones on 2019-03-09.
//  Copyright © 2019 Jose M Arguinzzones. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

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
       
        print("here are my runs: \(String(describing: Run.getAllRuns()))")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
         mapView.delegate = self
        manager?.startUpdatingLocation()
        
        //getLastRun()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        setupMapView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    func setupMapView() {
        if let overlay = addLastRunToMap() {
            if mapView.overlays.count > 0 {
                mapView.removeOverlays(mapView.overlays)////////
            }
            mapView.addOverlay(overlay)
            lasRunStack.isHidden = false
            lastRunBGView.isHidden = false
            lastRunCloseBtn.isHidden = false
        } else {
            lasRunStack.isHidden = true
            lastRunBGView.isHidden = true
            lastRunCloseBtn.isHidden = true
            centerMapOnUserLocation()
            
        }
    }
    
    func addLastRunToMap() -> MKPolyline? {
        guard let lastRun = Run.getAllRuns()?.first else {return nil}
        paceLbl.text = lastRun.pace.formatTimeDurationToString()
        distanceLbl.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        durationLbl.text = lastRun.duration.formatTimeDurationToString()
        
        var coodinates = [CLLocationCoordinate2D]()
        for location in  lastRun.locations {
            coodinates.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        }
        
        mapView.userTrackingMode = .none
        mapView.setRegion(centerMapOnPrevRoute(locations: lastRun.locations), animated: true)
        
        return MKPolyline(coordinates: coodinates, count: lastRun.locations.count)
        
    }
    
    func centerMapOnUserLocation() {
        mapView.userTrackingMode = .follow
        let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func centerMapOnPrevRoute(locations: List<Location>) -> MKCoordinateRegion {
        guard let initialLoc =  locations.first else { return MKCoordinateRegion() }
        var minLat = initialLoc.latitude
        var minLng = initialLoc.longitude
        var maxLat = minLat
        var maxLng =  minLng
        
        for location in locations {
            minLat = min(minLat, location.latitude)
            minLng = min(minLng, location.longitude)
            maxLat = max(maxLat, location.latitude)
            maxLng = max(maxLng, location.longitude)
        }
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (minLat + maxLat)/2, longitude: (minLng + maxLng)/2), span: MKCoordinateSpan(latitudeDelta: (maxLat - minLat)*1.4, longitudeDelta: (maxLng - minLng)*1.4))
    }

    @IBAction func lastRunCloseBtnPressed(_ sender: Any) {
        lasRunStack.isHidden = true
        lastRunBGView.isHidden = true
        lastRunCloseBtn.isHidden = true
        centerMapOnUserLocation()
        
    }
    @IBAction func locationCenterBtnPressed(_ sender: Any) {
        centerMapOnUserLocation()
    }
    
}
extension BeginRunVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            //mapView.userTrackingMode = .follow
        }
       
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        renderer.lineWidth = 3
        return renderer
    }
}



