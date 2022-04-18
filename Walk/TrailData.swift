//  TrailData.swift
//  NotLost
//  Created by Holger Hinzberg on 18.04.22.

import UIKit
import CoreLocation

struct CoordinatesData
{
    var locationName = ""
    var coordinate : (CLLocationDistance, CLLocationDistance)
}

struct TrailData
{
    let trailName: String
    var coordinatesData : [CoordinatesData]
}

extension TrailData
{
    static func getAllTrails() -> [TrailData]
    {
        var trails = [TrailData]()
        
        let coordinates1 = [
            CoordinatesData(locationName: "Emscherquellhof", coordinate: (51.49109637151158, 7.6146592071207335)),
            CoordinatesData(locationName: "Church Pfarrgemeinde Liebfrauen", coordinate: (51.49910608571362, 7.6163847330770365)),
            CoordinatesData(locationName: "Nursing Home Perthes-Haus", coordinate: (51.497530252361884, 7.612780604463348)),
            CoordinatesData(locationName: "Platz von Louviers", coordinate: (51.49858016138032, 7.620003790141576)),
        ]
        let trail1 = TrailData(trailName: "Hometown", coordinatesData: coordinates1)
        
        trails.append(trail1)
        return trails;
    }
}
