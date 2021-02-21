
import UIKit

class RegistrationTableViewController: UITableViewController {
    
    var registrations: [Registration] = []
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        return dateFormatter
    }()
    
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue) {

        guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController,
        let registration = addRegistrationTableViewController.registration else { return }

        registrations.append(registration)
        tableView.reloadData()
    }

    @IBSegueAction func showRegistration(_ coder: NSCoder, sender: Any?) -> AddRegistrationTableViewController? {
        guard
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell)
        else {
            return nil
        }
        
        let registration = registrations[indexPath.row]
        let addRegistrationTableViewController = AddRegistrationTableViewController(coder: coder)
        addRegistrationTableViewController?.existingRegistration = registration
        
        return addRegistrationTableViewController
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)

        let registration = registrations[indexPath.row]

        cell.textLabel?.text = registration.firstName + " " + registration.lastName
        cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkInDate) + " - " + dateFormatter.string(from: registration.checkOutDate) + ": " + registration.roomType.name

        return cell
    }

}
