import UIKit

class AddViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        // save new quiz
    }
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBackground()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func updateBackground() {
        
        for subview in self.view.subviews {
            if subview is GradientView {
                subview.removeFromSuperview()
            }
        }
        
        guard let primaryColour = UIColor(named: ColourName.Primary)?.cgColor else {
            return
        }
        
        guard let secondaryColour = UIColor(named: ColourName.Secondary)?.cgColor else {
            return
        }
        
        let gradientView = GradientView(frame: self.view.frame, colours: [primaryColour, secondaryColour])
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(gradientView, at: 0)
    }
}
