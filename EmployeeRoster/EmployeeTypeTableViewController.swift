//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by Mona Shamsolebad on 2019-09-11.
//

import UIKit

class EmployeeTypeTableViewController: UITableViewController {
    var employeeType : EmployeeType?
    weak var delegate: EmployeeTypeTableViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EmployeeType.all.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeTypeCellIdentifier", for: indexPath)
       
        let type = EmployeeType.all[indexPath.row]
      
        if type == self.employeeType {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = type.description()
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.employeeType = EmployeeType.all[indexPath.row]
        delegate?.didSelect(employeeType: employeeType!)
        tableView.reloadData()
    }
  


}
protocol EmployeeTypeTableViewControllerDelegate: class {
    func didSelect(employeeType: EmployeeType)
}
