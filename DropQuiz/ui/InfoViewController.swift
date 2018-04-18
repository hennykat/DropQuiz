import UIKit

class InfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPopoverPresentationControllerDelegate {
    
    public var quiz: Quiz?
    private var questionList = [Question]()
    
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
        navToQuiz()
    }
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let infoQuiz = quiz else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        setupUI(infoQuiz)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // remove popover
        self.presentedViewController?.dismiss(animated: false, completion: nil)
        
        // don't show questions in landscape
        switch UIDevice.current.orientation {
          case .portrait:
            questionCollectionView.isHidden = false
          case .landscapeLeft:
            questionCollectionView.isHidden = true
          case .landscapeRight:
            questionCollectionView.isHidden = true
          default:
            questionCollectionView.isHidden = false
        }
    }
    
    // MARK: UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        self.questionCollectionView.isHidden = false
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let item = UIUtil.getListItem(at: indexPath, questionList) {
            showQuestionPopover(indexPath.row, item)
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewIdentifier.InfoQuestionCell, for: indexPath) as! InfoQuestionCell
        
        guard let item = UIUtil.getListItem(at: indexPath, questionList) else {
            return cell
        }
        
        cell.questionLabel.text = item.question
        
        return cell
    }
    
    // MARK: UI
    
    func setupUI(_ infoQuiz: Quiz) {
        
        questionList.append(contentsOf: infoQuiz.questions)
        questionCollectionView.register(UINib(nibName: ViewIdentifier.InfoQuestionCell, bundle: nil), forCellWithReuseIdentifier: ViewIdentifier.InfoQuestionCell)
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
        
        iconBackgroundView.layer.cornerRadius = iconBackgroundView.frame.width / 2
        iconImageView.image = infoQuiz.icon ?? UIImage(named: ImageName.Default)
        nameLabel.text = infoQuiz.name
        descriptionLabel.text = infoQuiz.information ?? ""

        let numQuestions = infoQuiz.questions.count
        if numQuestions == 1 {
            numQuestionsLabel.text = String(numQuestions) + ViewString.InfoQuestion
        } else {
            numQuestionsLabel.text = String(numQuestions) + ViewString.InfoQuestions
        }
    }
    
    func showQuestionPopover( _ index: Int, _ question: Question) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardIdentifier.Main, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewIdentifier.QuestionViewController) as! QuestionViewController
        viewController.index = index
        viewController.question = question
        
        // setup popover
        viewController.modalPresentationStyle = .popover
        viewController.preferredContentSize = CGSize(width: self.questionCollectionView.frame.width - 48, height: self.questionCollectionView.frame.height)
        viewController.popoverPresentationController?.delegate = self
        viewController.popoverPresentationController?.sourceView = self.questionCollectionView
        viewController.popoverPresentationController?.sourceRect = CGRect(x: self.questionCollectionView.bounds.midX, y: self.questionCollectionView.bounds.midY, width: 0, height: 0)
        viewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        
        self.questionCollectionView.isHidden = true
        self.present(viewController, animated: true, completion: nil)
    }
    
    // MARK: Nav
    
    func navToQuiz() {
        let storyBoard = UIStoryboard(name: StoryboardIdentifier.Main, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewIdentifier.QuizViewController) as! QuizViewController
        viewController.quiz = quiz
        self.present(viewController, animated: true, completion: nil)
    }
}
