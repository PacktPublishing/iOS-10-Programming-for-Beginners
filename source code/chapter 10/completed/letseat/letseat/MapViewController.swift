//
//  MapViewController.swift
//  LetsEat
//
//  Created by Craig Clayton on 11/15/16.
//  Copyright © 2016 Craig Clayton. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var lblLocation:UILabel!
    
    let manager = MapDataManager()
    var selectedRestaurant:RestaurantItem?
    var selectedCity:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Segue.showDetail.rawValue:
            showRestaurantDetail(segue: segue)
        case Segue.locationList.rawValue:
            showLocationList(segue: segue)
        default:
            print("Segue not added")
        }
    }
    
    func showLocationList(segue:UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController,
            let viewController = navController.topViewController as? LocationViewController else {
                return
        }
        
        guard let city = selectedCity else { return }
        viewController.selectedCity = city
    }
    
    @IBAction func unwindMapCanel(segue:UIStoryboardSegue) {}
    @IBAction func unwindMapDone(segue:UIStoryboardSegue) {
        if let viewController = segue.source as? LocationViewController {
            selectedCity = viewController.selectedCity
            if let location = selectedCity {
                lblLocation.text = location
                print("location \(location)")
                mapView.removeAnnotations(mapView.annotations)
                manager.fetch { (annotations) in
                    addMap(annotations)
                }
            }
        }
    }
    
    func initialize() {
//        mapView.delegate = self
        manager.fetch { (annotations) in
            addMap(annotations)
        }
    }
    
    func addMap(_ annotations:[RestaurantAnnotation]) {
        mapView.setRegion(manager.currentRegion(latDelta: 0.5, longDelta: 0.5), animated: true)
        mapView.addAnnotations(annotations)
    }
    
    func showRestaurantDetail(segue:UIStoryboardSegue) {
        if let viewController = segue.destination as? RestaurantDetailViewController, let restaurant = selectedRestaurant  {
            viewController.selectedRestaurant = restaurant
        }
    }
}

//extension MapViewController:MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        
//        guard let annotation = mapView.selectedAnnotations.first else { return }
//        let data = annotation as! RestaurantAnnotation
//        selectedRestaurant = data.restaurantItem
//        
//        self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
//    }
//    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let identifier = "custompin"
//        
//        guard !annotation.isKind(of: MKUserLocation.self) else {
//            return nil
//        }
//        
//        var annotationView:MKAnnotationView?
//        
//        if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
//            annotationView = customAnnotationView
//            annotationView?.annotation = annotation
//        }
//        else {
//            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            annotationView = av
//        }
//        
//        if let annotationView = annotationView {
//            annotationView.canShowCallout = true
//            annotationView.image = UIImage(named: "custom-annotation")
//        }
//        
//        return annotationView
//    }
//}














