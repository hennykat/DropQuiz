import UIKit

class AddViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var iconBackgroundView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        // TODO: save new quiz
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: fix this on screen rotate
        if let lightColour = UIColor(named: ColourName.Light)?.cgColor {
            nameTextField.underline(colour: lightColour, thickness: 2.0)
            descriptionTextField.underline(colour: lightColour, thickness: 2.0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UI
    
    func setupUI() {
        
        iconBackgroundView.layer.cornerRadius = iconBackgroundView.frame.width / 2
        iconImageView.image = UIImage(named: ImageName.Default)
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: ViewString.AddName, attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: ColourName.Light) as Any])
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: ViewString.AddDescription, attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: ColourName.Light) as Any])
    }
    
}
