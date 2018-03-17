//
//  MapViewController.swift
//  NARUTO
//
//  Created by Kxy on 2018/1/17.
//  Copyright © 2018年 Kxy. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController,UISearchBarDelegate {
    var place = "成都"
    var exactPlace:String?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var locationManager = CLLocationManager()
    var userLoc = CLLocationManager()
    var currlLoc = CLLocation()
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //弹出请求权限提示
        userLoc.requestWhenInUseAuthorization()
        
        //用户位置追踪
        self.mapView.userTrackingMode = .none
       searchBar.delegate = self
       
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder();
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar.text != nil {
            place = searchBar.text!
            exactPlace =  place
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(place) { (placeMarkes, error) in
                guard let placeMarkes = placeMarkes else {
                    print(error  ?? "未找到该地名")
                    let alet = UIAlertController(title: "错误", message: "未找到该地址", preferredStyle: UIAlertControllerStyle.alert)
                    let asht = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                    alet.addAction(asht)
                    self.present(alet, animated: true, completion: nil)
                    
                    return
                }
                let location = placeMarkes.first
                let annotation = MKPointAnnotation()
                annotation.title = self.exactPlace
                // annotation.subtitle = self.exactPlace
                
                if let loc = location?.location {
                    annotation.coordinate = loc.coordinate
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        
        
         searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
   
    @IBAction func biaozhunMap(_ sender: Any) {
        mapView.mapType = .standard
    }
    
    @IBAction func weixinMap(_ sender: Any) {
        mapView.mapType = .satellite
    }
    
    @IBAction func hunheMap(_ sender: Any) {
        mapView.mapType = .hybrid
    }
    @IBAction func selfLoc(_ sender: Any) {
        self.mapView.userTrackingMode = .follow
      // self.mapView.setRegion(MKCoordinateRegion.init(center: currlLoc.coordinate, span: self.mapView.region.span), animated: true)
    }
    
//    func requestLocation(){
//
//    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
   

}
