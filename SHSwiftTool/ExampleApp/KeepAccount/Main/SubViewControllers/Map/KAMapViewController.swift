//
//  KAMapViewController.swift
//  SHSwiftTool
//
//  Created by Seok Ho on 2020/04/30.
//  Copyright © 2020 SWein. All rights reserved.
//

import UIKit
import MapKit

class KAMapViewController: UIViewController {
    
    @IBOutlet var rootView: UIView!
    @IBOutlet var mapView: MKMapView!
    
    private var latitude: Double = 0
    private var longitude: Double = 0
    
    private var currentRoute: MKRoute?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NavigationUtil.hideSystemNavigationBar(navigationController: self.navigationController!)
        
        
        rootView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - CGFloat(KAConstants.BOTTOM_TAB_BAR_HEIGHT))
        
        mapViewSetting()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initLocation()
        addAnnotations()
    }
    
    private func mapViewSetting() {
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
    
    private func initLocation() {
        ILog.debug(tag: #file, content: "initLocation")
        
        LocationWrapper.getInstance().requestLocation({
            
            AlertViewUtil.showTwoButtonAlertView(from: self, setTitle: "Permission", setMessage: "You need agree location permission", setConfirmButtonTitle: "Confirm", setCancelButtonTitle: "Cancel", setConfirmDelegate: {
                _ in
                
                PermissionUtil.openAppSettingPage()
               
            }, setCancelDelegate: {
                _ in
                ViewControllerUtil.finishSelf(view: self)
            })
            
        }, onLocateFinished: {
            
            self.latitude = LocationWrapper.getInstance().currentLocation.coordinate.latitude
            self.longitude = LocationWrapper.getInstance().currentLocation.coordinate.longitude
            
            ILog.debug(tag: #file, content: "location [\(self.latitude), \(self.longitude)]")
            self.zoomToLastLocation(with: LocationWrapper.getInstance().currentLocation.coordinate)
            
            self.constructRoute(userLocation: LocationWrapper.getInstance().currentLocation.coordinate)
            
            LocationWrapper.getInstance().stopLocation()
        })
    }
    
    private func zoomToLastLocation(with coordinate: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
    
    private func addAnnotations() {
        let park = MKPointAnnotation()
        park.title = "title"
        park.subtitle = "sub title"
        park.coordinate = CLLocationCoordinate2D(latitude: 37.017859436796265, longitude: 127.03772685904038)
        
        mapView.addAnnotation(park)
    }
    
    ///go to project -> targets -> Signing&Capabilities : add map than select route ways that you need
    private func constructRoute(userLocation: CLLocationCoordinate2D) {
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        directionsRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.017859436796265, longitude: 127.03772685904038)))
        directionsRequest.requestsAlternateRoutes = true
        directionsRequest.transportType = MKDirectionsTransportType.automobile
        
        let directions = MKDirections(request: directionsRequest)
        directions.calculate(completionHandler: {
            (directionsResponse, error) in
            
            if let error = error {
                ILog.debug(tag: #file, content: error.localizedDescription)
            }
            else if let response = directionsResponse, response.routes.count > 0 {
                self.currentRoute = response.routes[0]
                self.mapView.addOverlay(response.routes[0].polyline)
                self.mapView.setVisibleMapRect(response.routes[0].polyline.boundingMapRect, animated: true)
            }
        })
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

extension KAMapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let currentRoute = self.currentRoute else {
            return MKOverlayRenderer()
        }
       
        let polyLineRenderer = MKPolylineRenderer(polyline: currentRoute.polyline)
        polyLineRenderer.strokeColor = UIColor.orange
        polyLineRenderer.lineWidth = 5
       
        return polyLineRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationview = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        
        if annotationview == nil {
            annotationview = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        
        if annotation.title == "title" {
            annotationview?.image = UIImage(named: "test_earth_annotation.png")
        }
        else if annotation === mapView.userLocation {
            annotationview?.image = UIImage(named: "test_home_annotation.png")
        }
        
        // 点击后是否提示气泡
        annotationview?.canShowCallout = true
        
        return annotationview
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        ILog.debug(tag: #file, content: "select \(String(describing: view.annotation?.title))")
    }
    
}
