//  ARCLViewController.swift
//  Created by Mohammad Azam on 4/8/22.

import UIKit
import ARCL
import CoreLocation
import SwiftUI

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
    
    override func viewDidLayoutSubviews()
    {
      super.viewDidLayoutSubviews()
      sceneLocationView.frame = view.bounds
    }
    
    private func plot()
    {
        let borderColor = UIColor.black.cgColor
        let backgroundColor = UIColor.white
        let primaryTextColor = UIColor.label
        let secondaryTextColor = UIColor.secondaryLabel
        let labelHight = 20
                
        for coordinateData in trail!.coordinatesData
        {
            let coordinate = CLLocationCoordinate2D(latitude:  coordinateData.coordinate.0, longitude: coordinateData.coordinate.1)
            let location = CLLocation(coordinate: coordinate, altitude: altitude)
            
            let locationNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: labelHight))
            locationNameLabel.text = coordinateData.locationName
            locationNameLabel.layer.masksToBounds = true
            locationNameLabel.textAlignment = .center
            locationNameLabel.textColor = primaryTextColor
            locationNameLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
                                    
            let distanceLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: labelHight))
            let distanceInMeters = locationManager.location?.distance(from: location)
            let distanceInKilometers = distanceInMeters! / 1000.0
            let formattedDistance = getFormattedDistance(distance: distanceInKilometers)
            distanceLabel.text = String(format: "%@ km", formattedDistance)
            distanceLabel.textColor = secondaryTextColor
            distanceLabel.textAlignment = .center
            distanceLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
 
            let locationSize = getLabelTextSize(label: locationNameLabel)
            let distanceSize = getLabelTextSize(label: distanceLabel)
            let maxWidth = max(locationSize.width, distanceSize.width)
            
            let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: Int(maxWidth) + 20, height: labelHight * 3))
            stackView.alignment = .fill
            stackView.distribution = .equalSpacing
            stackView.addArrangedSubview(UILabel())
           stackView.addArrangedSubview(locationNameLabel)
            stackView.addArrangedSubview(distanceLabel)
            stackView.addArrangedSubview(UILabel())
            stackView.axis = .vertical
            stackView.backgroundColor = backgroundColor
            stackView.layer.masksToBounds = true
            stackView.layer.cornerRadius = 5
            stackView.layer.borderColor = borderColor
            stackView.layer.borderWidth = 1
                                        
            let annotationNode = LocationAnnotationNode(location: location, view: stackView)
            sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        }
    }
    
    func getFormattedDistance(distance : Double) -> String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.maximumFractionDigits = 2;
        formatter.minimumFractionDigits = 2;
        formatter.locale = Locale.current
        let string = formatter.string(from: NSNumber(value: distance))
        return string!
    }
    
    func getLabelTextSize( label: UILabel) -> CGSize
    {
        let theText = label.text as NSString?
        let theSize = theText?.boundingRect(with: self.view.frame.size, options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin],
                                     attributes: [NSAttributedString.Key.font: label.font as Any ], context: nil).size
        return theSize!
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
}

