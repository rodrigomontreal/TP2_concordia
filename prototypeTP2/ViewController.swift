
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    //--------------------------------
    //Connection champ nom du étudiante
    @IBOutlet weak var student_name_field: UITextField!
    //Connection tableView - le nom du étudiante apparaitre dans table
    @IBOutlet weak var student_name_tableview: UITableView!
    
    //--------------------------------
    typealias studentName = String
    typealias course = String
    typealias grade = Double
    //--------------------------------
    // Appeler la class UserDefaultManager()
    let userDefautsObj = UserDefaultsManager()
    //Variable un tableau dans l'autre tableau: clé est le nom d'étudiante
    var studentGrades: [studentName: [course: grade]]!
    //--------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserDefaults()
    }
    //--------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentGrades.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = [studentName](studentGrades.keys)[indexPath.row]
        return cell
    }
    //Command pour suprimmer le row dans le tableauView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            let name = [studentName](studentGrades.keys)[indexPath.row]
            studentGrades[name] = nil
            userDefautsObj.setKey(theValue: studentGrades as AnyObject, theKey: "grades")
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    

    //Commande pour mémoriser le nom du étudiante et afficher dans l'autre interface
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = [studentName](studentGrades.keys)[indexPath.row]
        userDefautsObj.setKey(theValue: name as AnyObject, theKey: "name")
        performSegue(withIdentifier: "seg", sender: nil)
    }
     //---------
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //--------------------------------
   //connection type Action pour ajouter un étudiante dans le programme
    @IBAction func addStudent(_ sender: UIButton) {
        if student_name_field.text != "" {
            studentGrades[student_name_field.text!] = [course: grade]()
            student_name_field.text = ""
            userDefautsObj.setKey(theValue: studentGrades as AnyObject, theKey: "grades")
            student_name_tableview.reloadData()
            
        }
    }
    
    
    //Faire le salvegarde du étudiante e ses grades , utilise le méthode de tableau de la variable qui a défini dessus
    func loadUserDefaults(){
        if userDefautsObj.doesKeyExist(theKey: "grades"){
            studentGrades = userDefautsObj.getValue(theKey: "grades") as!
                [studentName: [course: grade]]
        } else {
            studentGrades = [studentName: [course: grade]]()
        }
    }
    
    //--------------------------------
}

