import UIKit

class AddViewController: UIViewController, UIPopoverPresentationControllerDelegate, IconPickerDelegate {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var iconBackgroundView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        // TODO: don't show this if there arent any changes
        showCancelAlert()
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        showSaveAlert()
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
    
    // MARK: UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: IconPickerDelegate
    
    func iconPicked(iconName: String) {
        self.iconImageView.image = UIImage(named: iconName)
    }
    
    // MARK: UI
    
    func setupUI() {
        
        iconBackgroundView.layer.cornerRadius = iconBackgroundView.frame.width / 2
        iconImageView.image = UIImage(named: ImageName.Default)
        // make icon clickable
        let iconTapGesture = UITapGestureRecognizer(target: self, action: #selector(iconImageTapped(gesture:)))
        iconImageView.addGestureRecognizer(iconTapGesture)
        iconImageView.isUserInteractionEnabled = true
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: ViewString.AddName, attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: ColourName.Light) as Any])
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: ViewString.AddDescription, attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: ColourName.Light) as Any])
    }
    
    @objc func iconImageTapped(gesture: UIGestureRecognizer) {
        showIconPickerPopover()
    }
    
    func showIconPickerPopover() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardIdentifier.Main, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewIdentifier.IconPickerViewController) as! IconPickerViewController
        viewController.delegate = self
        
        // setup popover
        viewController.modalPresentationStyle = .popover
        viewController.preferredContentSize = CGSize(width: self.view.frame.width - 48, height: self.view.frame.height / 2)
        viewController.popoverPresentationController?.delegate = self
        viewController.popoverPresentationController?.sourceView = self.view
        viewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        viewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    func showSaveAlert() {
        
        let alert = UIAlertController(title: ViewString.AddSaveAlertTitle, message: ViewString.AddSaveAlertMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: ViewString.AddSaveAlertDefault, style: .default, handler: { action in
            // TODO: save quiz
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: ViewString.AddSaveAlertCancel, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showCancelAlert() {
        
        let alert = UIAlertController(title: ViewString.AddCancelAlertTitle, message: ViewString.AddCancelAlertMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: ViewString.AddCancelAlertCancel, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: ViewString.AddCancelAlertDestructive, style: .destructive, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
