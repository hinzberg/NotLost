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
            CoordinatesData(locationName: "Shop", coordinate: (51.49792994645357, 7.612256782547854)),
            CoordinatesData(locationName: "Church", coordinate: (51.499052661223395, 7.61587420796521)),
            CoordinatesData(locationName: "Pond", coordinate: (51.498941755500326, 7.618324414303657)),
            CoordinatesData(locationName: "Field", coordinate: (51.49689241181979, 7.616560986478088)),
        ]
        let trail1 = TrailData(trailName: "Hometown", coordinatesData: coordinates1)
        
        trails.append(trail1)
        return trails;
    }
}
