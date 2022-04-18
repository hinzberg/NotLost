//  ViewController.swift
//  Walk
//  Created by Mohammad Azam on 4/8/22.

import UIKit
import ARCL
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var trail: Trail?
    
    var sceneLocationView = SceneLocationView()
    var locationManager = CLLocationManager()
    
    var altitude: CLLocationDistance = 30
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
    }
    
    private func plot() {
        
        for (index, coordinate) in trail!.coordinates.enumerated()
        {
            let coordinate = CLLocationCoordinate2D(latitude: coordinate.0, longitude: coordinate.1)
            let location = CLLocation(coordinate: coordinate, altitude: altitude)
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
            label.text = "\(index + 1)"
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 10
            label.textAlignment = .center
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 18.0)
            
            let distanceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
            let distanceInMeters = locationManager.location?.distance(from: location)
            let miles = distanceInMeters! * 0.000621371192
            distanceLabel.text = String(format: "%.2f miles", miles)
            distanceLabel.textColor = .white
            distanceLabel.textAlignment = .center
            
            let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 150, height: 60))
            stackView.addArrangedSubview(label)
            stackView.addArrangedSubview(distanceLabel)
            stackView.axis = .vertical
            stackView.backgroundColor = .black
            stackView.layer.masksToBounds = true
            stackView.layer.cornerRadius = 10
            
            let annotationNode = LocationAnnotationNode(location: location, view: stackView)
            sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("FIRED")
        if let location = locations.first {
            print(location.altitude)
            altitude = location.altitude
            sceneLocationView.removeAllNodes()
            plot()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = view.bounds
    }

}

