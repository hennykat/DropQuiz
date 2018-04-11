import UIKit

class InfoViewController: UIViewController {
    
    public var quiz: Quiz?
    
    // MARK: IBOutlet
    
    @IBOutlet weak var iconBackgroundView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numQuestionsLabel: UILabel!
    @IBOutlet weak var questionCollectionView: UICollectionView!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        // TODO: start quiz
    }
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let infoQuiz = quiz else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        iconBackgroundView.layer.cornerRadius = iconBackgroundView.frame.width / 2
        iconImageView.image = infoQuiz.icon ?? UIImage(named: ImageName.Default)
        nameLabel.text = infoQuiz.name
        descriptionLabel.text = infoQuiz.description ?? ""
        // TODO: abstract this
        let numQuestions = infoQuiz.questions.count
        if numQuestions == 1 {
            numQuestionsLabel.text = String(numQuestions) + " question"
        } else {
            numQuestionsLabel.text = String(numQuestions) + " questions"
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
