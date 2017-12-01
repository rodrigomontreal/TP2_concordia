
import UIKit
//--------------------------
class Interface2Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    //--------------------------
    //Connection  tableView - type outlet
    @IBOutlet weak var course_grade_tableview: UITableView!
    // connection pour afficher le nom du étudiante
    @IBOutlet weak var student_name_label: UILabel!
    //connection champ pour ajouter le nom du course
    @IBOutlet weak var course_field: UITextField!
    //connection champ pour ajouter le grade
    @IBOutlet weak var grade_field: UITextField!
    //connection champ pour afficher le moyenne final(regle de 3)
    @IBOutlet weak var average: UILabel!
    
    
    typealias studentName = String
    typealias course = String
    typealias grade = Double
    
     //--------------------------
    let userDefautsObj = UserDefaultsManager()
    var studentGrades: [studentName: [course: grade]]!
    var ArrOfCourses: [course]!
    var arrOfGrades: [grade]!
    
    //--------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        student_name_label.text = userDefautsObj.getValue(theKey: "name") as? String
        loadUserDefaults()
        fillUpArray()
        //average.text = String(format: "Average: %0.1f", average_final(tabNotes: arrOfGrades, moyenne: {$0 / $1}))
        average.text = verifAverage(dictDeNotes: moienne(), regleDe3:{ $0 * 100.0 / $1})
    }
    //--------------------------
    func fillUpArray() {
    let name = student_name_label.text
    let courses_and_grades = studentGrades[name!]
    ArrOfCourses = [course](courses_and_grades!.keys)
    arrOfGrades = [grade](courses_and_grades!.values)
    }
    
    
    //--------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrOfCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = course_grade_tableview.dequeueReusableCell(withIdentifier: "proto")!
        if let aCourse = cell.viewWithTag(100) as! UILabel! {
            aCourse.text = ArrOfCourses[indexPath.row]
        }
        if let aGrade = cell.viewWithTag(101) as! UILabel! {
            aGrade.text = String(arrOfGrades[indexPath.row])
        }
        
        
        return cell
    }
    // TableView 
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let name = student_name_label.text
            var courses_and_grades = studentGrades[name!]!
            let note = [course](courses_and_grades.keys)[indexPath.row]
            courses_and_grades[note] = nil
            studentGrades[name!] = courses_and_grades
            userDefautsObj.setKey(theValue: studentGrades as AnyObject, theKey: "grades")
            fillUpArray()
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
 
    //--------------------------
    
    func loadUserDefaults(){
        if userDefautsObj.doesKeyExist(theKey: "grades"){
            studentGrades = userDefautsObj.getValue(theKey: "grades") as!
                [studentName: [course: grade]]
        } else {
            studentGrades = [studentName: [course: grade]]()
        }
    }
 //--------------------------
    //Button pour ajouter le course et le grade à chaque étudiante
    @IBAction func save_corse_and_grade(_ sender: UIButton) {
        let name = student_name_label.text!
        var student_courses = studentGrades[name]!
        student_courses[course_field.text!] = Double(grade_field.text!)
        studentGrades[name] = student_courses
        userDefautsObj.setKey(theValue: studentGrades as AnyObject, theKey: "grades")
        fillUpArray()
        course_grade_tableview.reloadData()
        average.text = verifAverage(dictDeNotes: moienne(), regleDe3:{ $0 * 100.0 / $1})
    }
    
    //-------   
  
    //Méthode reduce - faire moyenne
 /*
        func average_final(tabNotes: [Double], moyenne: (_ sum: Double, _ nombreDeNotes: Double) -> Double) -> Double {
            let somme = tabNotes.reduce(0, +)
            let resultat = moyenne(somme, Double(tabNotes.count ))
            return resultat
        
    }
  */
 //---------
    //Le code pour calculer le regle de 3
    func verifAverage(dictDeNotes: [Double: Double], regleDe3: (_ somme: Double, _ sur: Double) -> Double) -> String{
        
        let sommeNotes = [Double](dictDeNotes.keys).reduce(0, +)
        let sommesur = [Double](dictDeNotes.values).reduce(0, +)
        let conversion = regleDe3(sommeNotes, sommesur)
        return String(format: "Average = %0.1f/%0.1f or %0.1f/100", sommeNotes, sommesur, conversion)
        
    }
    //fonction pour calculer la moyenne
    func moienne () ->  [Double: Double] {
        let average = arrOfGrades.reduce(0, +)
        let somme = arrOfGrades.count
        let moienne = Double(average/Double(somme))
        let dictNotes = [moienne: 10.0]
        return dictNotes
    }
    
    //---
}
    
    
    
    
    
    
    
    
    
    
    
    
    

    
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  /*
    func average(arrOfGrades: [Double], moyenne: (_ sum: Double, _ nombreDeNotes: Double) -> Double) -> Double {
        let somme = arrOfGrades.reduce(0, +)
        let resultat = moyenne(somme, Double(arrOfGrades.count))
        return resultat
    }
    
    let moyenne = String(format: "%0.1f", average(arrOfGrades: grade, moyenne: {$0 / $1}))
    
   // print(this)
    */
  //-----
  //produit croise
    /*
    func produitCroise(dictDeNotes: [Double: Double],
                       regleDe3:(_ somme: Double, _ sur:Double) -> Double) ->
        String{
        let sommeNotes = [Double](dictDeNotes.keys).reduce(0, +)
        let sommeSur = [Double](dictDeNotes.values).reduce(0, +)
        let conversion = regleDe3(sommeNotes, sommeSur)
            return String(format: "Grade = %0.1f/%0.1f or %0.1f/100",
            sommeNotes, sommeSur, conversion)
            }
   // let dictNotes = [12.5: 20.0, 13.8: 20.0, 55.3: 50.0, 77.4: 100.0]
  //  print(produitCroise(dictdeNotes: dictNotes){ $0 * 100.0 / $1 })
    
*/
    
    
   //--------------------------


