
import UIKit

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate , EmployeeTypeTableViewControllerDelegate {
    
    func didSelect(employeeType: EmployeeType) {
        self.employeeType = employeeType
        employeeTypeLabel.text = employeeType.description()
        employeeTypeLabel.textColor = .black
        
    }
    
    struct PropertyKeys {
        static let unwindToListIndentifier = "UnwindToListSegue"
    }
    var employeeType : EmployeeType?
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        dobLabel.text = dateFormatter.string(from: dobDatePicker.date)
    }
    
    var employee: Employee?
    
    @IBOutlet var dobDatePicker: UIDatePicker!
    
    var isEditingBirthday: Bool = false {
        didSet{
           dobDatePicker.isHidden = !isEditingBirthday
        }
    }
    
    let datePickerCellIndexPath = IndexPath(row: 2, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            if let destinationVC = segue.destination as? EmployeeTypeTableViewController {
                destinationVC.delegate = self
                destinationVC.employeeType = self.employee?.employeeType
            }
        }
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dobLabel.text = dateFormatter.string(from: employee.dateOfBirth)
            dobLabel.textColor = .black
            employeeTypeLabel.text = employee.employeeType.description()
            employeeTypeLabel.textColor = .black
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name = nameTextField.text {
            employee = Employee(name: name, dateOfBirth: dobDatePicker.date, employeeType: .exempt)
            performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
        }
        if let employeeType = employeeType {
            employee?.employeeType = employeeType
        }
       
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
        performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
    }
    
    // MARK: - Text Field Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerCellIndexPath:
            if isEditingBirthday {
                return 216.0
            } else {
                return 0
            }
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == IndexPath(row: 1, section: 0) { // 2 1
            isEditingBirthday = !isEditingBirthday
            dobLabel.textColor = .black
            dobDatePicker.date = Calendar.current.startOfDay(for: Date())
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }

}
