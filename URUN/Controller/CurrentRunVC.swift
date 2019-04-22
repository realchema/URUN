//
//  CurrentRunVC.swift
//  URUN
//
//  Created by Jose M Arguinzzones on 2019-04-20.
//  Copyright © 2019 Jose M Arguinzzones. All rights reserved.
//

import UIKit
import MapKit
class CurrentRunVC: LocationVC {

    @IBOutlet var swipeBGImageView: UIImageView!
    
    @IBOutlet var sliderImageView: UIImageView!
    
    @IBOutlet var durationLbl: UILabel!
    
    @IBOutlet var paceLbl: UILabel!
    
    @IBOutlet var distanceLbl: UILabel!
    
    @IBOutlet var pauseBtn: UIButton!
    
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var timer = Timer()
    var runDistance = 0.0
    var counter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(endRunSwiped(sender:)))
        sliderImageView.addGestureRecognizer(swipeGesture)
        sliderImageView.isUserInteractionEnabled = true
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        manager?.distanceFilter = 10
        startRun()
    }
    func startRun(){
        manager?.startUpdatingLocation()
        startTimer()
        
    }
    
    func endRun() {
        manager?.stopUpdatingLocation()
    }
    
    func startTimer(){
        durationLbl.text = counter.formatTimeDurationToString()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter(){
        counter += 1
        durationLbl.text = counter.formatTimeDurationToString()
        
    }
    
    
    @IBAction func pauseBtnPressed(_ sender: Any) {
    }
    
    @objc func endRunSwiped(sender: UIPanGestureRecognizer) {
        let minAdjust: CGFloat = 80
        let maxAdjust: CGFloat = 128
        if let sliderView = sender.view {
            if sender.state == UIGestureRecognizer.State.began || sender.state == UIGestureRecognizer.State.changed {
                let translation = sender.translation(in: self.view)
                if sliderView.center.x >= (swipeBGImageView.center.x - minAdjust) && sliderView.center.x <= (swipeBGImageView.center.x + maxAdjust) {
                    sliderView.center.x = sliderView.center.x + translation.x
                } else if sliderView.center.x >= (swipeBGImageView.center.x + maxAdjust) {
                    sliderView.center.x = swipeBGImageView.center.x + maxAdjust
                    //endRun()
                    dismiss(animated: true, completion: nil)
                } else {
                    sliderView.center.x = swipeBGImageView.center.x - minAdjust
                }
                
                sender.setTranslation(CGPoint.zero, in: self.view)
            } else if sender.state == UIGestureRecognizer.State.ended {
                UIView.animate(withDuration: 0.1, animations: {
                    sliderView.center.x = self.swipeBGImageView.center.x - minAdjust
                })
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CurrentRunVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            checkLocationAuthStatus()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
        }else if let location =  locations.last{
            runDistance += lastLocation.distance(from: location)
            distanceLbl.text = "\(runDistance.metersToMiles(places: 2))"
        }
        lastLocation = locations.last
    }
}
