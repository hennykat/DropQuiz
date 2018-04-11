import UIKit

class InfoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        // TODO: start quiz
    }
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let infoQuiz = quiz else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        questionList = infoQuiz.questions
        questionCollectionView.register(UINib(nibName: ViewIdentifier.InfoQuestionCell, bundle: nil), forCellWithReuseIdentifier: ViewIdentifier.InfoQuestionCell)
        questionCollectionView.delegate = self
        questionCollectionView.dataSource = self
        
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
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let item = getQuestionItem(indexPath) {
            // TODO: what happens on click?
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewIdentifier.InfoQuestionCell, for: indexPath) as! InfoQuestionCell
        
        guard let item = getQuestionItem(indexPath) else {
            return cell
        }
        
        cell.questionLabel.text = item.question
        
        return cell
    }
    
    // MARK: Util
    
    func getQuestionItem(_ indexPath: IndexPath) -> Question? {
        
        let index = indexPath.row
        if index < 0 || index >= questionList.count {
            print("failed to get question item, invalid index")
            return nil
        }
        
        return questionList[index]
    }
}
