//  TrailTableViewController.swift
//  Created by Mohammad Azam on 4/8/22.

import Foundation
import UIKit
import CoreLocation

class TrailTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailCell", for: indexPath)
        let trail = TrailData.getAllTrails()[indexPath.row]
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        cell.textLabel?.text = trail.trailName
        
        cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.detailTextLabel?.text = "\(trail.coordinatesData.count) points"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TrailData.getAllTrails().count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let vc = segue.destination as? ARCLViewController else { return }
        
        vc.trail = TrailData.getAllTrails()[indexPath.row]
        vc.title = "\(vc.trail!.trailName)  (\(vc.trail!.coordinatesData.count) Locations)"
    }
    
}
