//
//  TrailTableViewController.swift
//  Walk
//
//  Created by Mohammad Azam on 4/8/22.
//

import Foundation
import UIKit
import CoreLocation

struct Trail {
    let name: String
    let coordinates: [(CLLocationDistance, CLLocationDistance)]
}

extension Trail {
    
    static func getAllTrails() -> [Trail] {
        
        return [
            Trail(name: "Bear Lake to Sky Pond", coordinates: [(40.31199571808244, -105.64598735087725), (40.31075545905206, -105.6450166201075), (40.309130632969385, -105.64404595823827), (40.30689071122293, -105.642419834113), (40.30594838378468, -105.63882678795633), (40.30390058825895, -105.63852405316815), (40.30420831600081, -105.6396208935199), (40.30307376145339, -105.63959577312629), (40.30178532892439, -105.63868815682387), (40.30098725259506, -105.63934353149016), (40.30091042163418, -105.64091948096187), (40.29975658224272, -105.6404909424976), (40.29959305677218, -105.63936891092678), (40.298025865799225, -105.64061718126698), (40.297218314381205, -105.643214248287), (40.29756451567344, -105.64562211805243), (40.2967952487718, -105.64692053485115), (40.29543949093343, -105.64876122481157), (40.29482400940896, -105.65110602470146), (40.29399713821045, -105.65437131598105), (40.29360290536857, -105.65797689485517), (40.291650860234554, -105.65919971184877), (40.29016035746496, -105.66272971561668), (40.28779473038906, -105.66425512355559), (40.285188560819414, -105.66540236011068), (40.28270726337281, -105.66544023597872), (40.28014900804328, -105.66740692605376)])
        ]
       
    }
    
}

class TrailTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailCell", for: indexPath)
        let trail = Trail.getAllTrails()[indexPath.row]
        cell.textLabel?.text = trail.name
        cell.detailTextLabel?.text = "\(trail.coordinates.count) points"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Trail.getAllTrails().count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        guard let vc = segue.destination as? ViewController else { return }
        vc.trail = Trail.getAllTrails()[indexPath.row]
        vc.title = "\(vc.trail!.name) \(vc.trail!.coordinates.count)"
        
        
        
    }
    
}
