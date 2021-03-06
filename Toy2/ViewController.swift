import UIKit

extension UIViewController {
    @objc func dismissKeyboard() {
        view.endEditing(false)
    }
    func dismissKeyBoardWhenTappingAround() {
         let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
         view.addGestureRecognizer(tap)
    }
    
}

class ViewController: UIViewController {
    
    var submitted : Bool = false
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var ClassTextField: UITextField!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ClassLabel: UILabel!
    @IBOutlet weak var DisplayLabel: UILabel!
    @IBOutlet weak var SubmitButton: UIButton!
    
    func enterClearMode() -> Void {
        submitted = true
        NameLabel.isHidden = true
        ClassLabel.isHidden = true
        NameTextField.isHidden = true
        ClassTextField.isHidden = true
        SubmitButton.setTitle("Clear", for: .normal)
    }
    
    func enterSubmitMode() -> Void {
        submitted = false
        NameLabel.isHidden = false
        ClassLabel.isHidden = false
        NameTextField.isHidden = false
        ClassTextField.isHidden = false
        DisplayLabel.isHidden = true
        SubmitButton.setTitle("Submit", for: .normal)
    }
    
    @IBAction func SubmitButtonTapped(_ sender: Any) {
        if (submitted) {
            enterSubmitMode()
UserDefaults.standard.removeObject(forKey: "name")
UserDefaults.standard.removeObject(forKey: "class")
            
        } else {
           
            enterClearMode()
            let name = NameTextField.text ?? ""
            let classYr = ClassTextField.text ?? ""
            DisplayLabel.text = "Welcome, " + name + " of " + classYr + "!"
            NameTextField.text = ""
            ClassTextField.text = ""
            DisplayLabel.isHidden = false
UserDefaults.standard.set(name, forKey: "name")
UserDefaults.standard.set(classYr, forKey: "class")
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyBoardWhenTappingAround()
        if (UserDefaults.standard.object(forKey: "name") != nil) {
            let name = UserDefaults.standard.string(forKey: "name")
            let classYr = UserDefaults.standard.string(forKey: "class")
            DisplayLabel.text = "Welcome, " + name! + " of " + classYr! + "!"
            enterClearMode()
        } else {
            enterSubmitMode()
        }
        if (Dog.NumberOfDogs == 0) {
            Dog.loadCats{(result) in
                for dict in result {
                    let imageURL = URL(string: dict["image"]!)
                    let image = UIImage(data: try! Data(contentsOf: imageURL!) )
                    Dog.AddDog(name: dict["name"]!, image: image!, age: Int(dict["age"]!), type: dict["type"]!)
            }
        }
    }
}
}
