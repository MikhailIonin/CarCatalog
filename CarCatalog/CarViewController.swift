//
//  ViewController.swift
//  CarCatalog
//
//  Created by Михаил Ионин on 19.09.2020.
//  Copyright © 2020 Михаил Ионин. All rights reserved.
//

import UIKit

class CarViewController: UITableViewController {

    let carInfoArray = ["Year: 2011","Vendor: Volkswagen","Model: Jetta", "Body type: Sedan"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

//Tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carInfoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarInfoCell", for: indexPath)
        cell.textLabel?.text = carInfoArray[indexPath.row]
    
        return cell
    }
 }

