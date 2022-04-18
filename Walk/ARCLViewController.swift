//  ViewController.swift
//  Walk
//  Created by Mohammad Azam on 4/8/22.

import UIKit
import ARCL
import CoreLocation

class ARCLViewController: UIViewController, CLLocationManagerDelegate {

    var trail: TrailData?
    
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
    
    private func plot()
    {
        let borderColor = UIColor.black.cgColor
        let backgroundColor = UIColor.white
        let textColor = UIColor.black
        let labelHight = 20
        
        for (index, coordinateData) in trail!.coordinatesData.enumerated()
        {
            let coordinate = CLLocationCoordinate2D(latitude:  coordinateData.coordinate.0, longitude: coordinateData.coordinate.1)
            let location = CLLocation(coordinate: coordinate, altitude: altitude)
            
            let enumeratedLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: labelHight))
            enumeratedLabel.text = "\(index + 1). Point"
            enumeratedLabel.layer.masksToBounds = true
            enumeratedLabel.textAlignment = .center
            enumeratedLabel.textColor = textColor
            enumeratedLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            
            let locationNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: labelHight))
            locationNameLabel.text = coordinateData.locationName
            locationNameLabel.layer.masksToBounds = true
            locationNameLabel.textAlignment = .center
            locationNameLabel.textColor = textColor
            locationNameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
                                    
            let distanceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: labelHight))
            let distanceInMeters = locationManager.location?.distance(from: location)
            let distanceInKilometers = distanceInMeters! / 1000.0
            // let distanceInMiles = distanceInMeters! * 0.000621371192
            distanceLabel.text = String(format: "%.2f km", distanceInKilometers)
            distanceLabel.textColor = textColor
            distanceLabel.textAlignment = .center
            distanceLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
                        
            let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 170, height: labelHight * 3))
            stackView.alignment = .fill
            stackView.distribution = .equalSpacing
            stackView.addArrangedSubview(enumeratedLabel)
           stackView.addArrangedSubview(locationNameLabel)
            stackView.addArrangedSubview(distanceLabel)
            stackView.axis = .vertical
            stackView.backgroundColor = backgroundColor
            stackView.layer.masksToBounds = true
            stackView.layer.cornerRadius = 5
            stackView.layer.borderColor = borderColor
            //stackView.layer.borderWidth = 4
                 
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

