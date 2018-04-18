import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var quizList = [Quiz]()
    
    // MARK: IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBackground()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateQuizList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // check if add
        if indexPath.row == (quizList.count - 1) {
            navToAddView()
            return
        }
        
        if let item = UIUtil.getListItem(at: indexPath, quizList) {
            navToInfoView(item)
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewIdentifier.HomeQuizCell, for: indexPath) as! HomeQuizCell
        
        guard let item = UIUtil.getListItem(at: indexPath, quizList) else {
            return cell
        }
        
        cell.nameLabel.text = item.name
        cell.iconImageView.image = item.icon
        
        return cell
    }
    
    // MARK: Collection Util
    
    func updateQuizList() {
        
        quizList.removeAll()
        collectionView.reloadData()
        
        if let quizzes = Storage.shared.loadQuizList() {
            quizList.append(contentsOf: quizzes)
        }
        
        // TODO: remove, for testing purposes v
        let testQuestion1 = Question(question: "What is sushi?", answers: ["raw fish", "vegetables", "milk", "monkeys"], index: 0)
        let testQuestion2 = Question(question: "Which is green?", answers: ["tomato", "onion", "lettuce", "nuts"], index: 2)
        let testQuestion3 = Question(question: "Which is food?", answers: ["grass", "dirt", "rocks", "sushi"], index: 3)
        let testQuiz = Quiz(name: "test", information: "this is a test quiz", icon: UIImage(named: ImageName.Star), questions: [Question]())
        testQuiz.questions.append(testQuestion1)
        testQuiz.questions.append(testQuestion2)
        testQuiz.questions.append(testQuestion3)
        quizList.append(testQuiz)
        // TODO: remove, for testing purposes ^
        
        let addQuiz = makeAddQuiz()
        quizList.append(addQuiz)
        collectionView.reloadData()
    }
    
    func makeAddQuiz() -> Quiz {
        return Quiz(name: ViewString.HomeAdd, icon: UIImage(named: ImageName.Add)!)
    }
    
    // MARK: UI
    
    func setupUI() {
        
        collectionView.register(UINib(nibName: ViewIdentifier.HomeQuizCell, bundle: nil), forCellWithReuseIdentifier: ViewIdentifier.HomeQuizCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // add long press delete
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPressed(gesture:)))
        longPressGestureRecognizer.minimumPressDuration = 0.75
        longPressGestureRecognizer.delaysTouchesBegan = true
        self.collectionView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func cellLongPressed(gesture : UILongPressGestureRecognizer!) {
    
        // only trigger on up
        if gesture.state != .ended {
            return
        }
        
        // get list item
        let position = gesture.location(in: self.collectionView)
        if let indexPath = self.collectionView.indexPathForItem(at: position) {
            
            // check if add
            if indexPath.row == (quizList.count - 1) {
                return
            }
            
            let quiz = UIUtil.getListItem(at: indexPath, quizList)
            showDeleteAlert(quiz: quiz)
        }
    }
    
    func updateBackground() {
        
        for subview in self.view.subviews {
            if subview is GradientView {
                subview.removeFromSuperview()
            }
        }
        
        guard let darkColour = UIColor(named: ColourName.Dark)?.cgColor else {
            return
        }
        
        guard let secondaryColour = UIColor(named: ColourName.Secondary)?.cgColor else {
            return
        }
        
        let gradientView = GradientView(frame: self.view.frame, colours: [darkColour, secondaryColour], locations: [0.0, 1.0])
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(gradientView, at: 0)
    }
    
    func showDeleteAlert(quiz: Quiz?) {
        
        guard let deleteQuiz = quiz else {
            print("failed to show delete quiz, invalid quiz")
            return
        }
        
        let msg = ViewString.HomeDeleteAlertMsg + deleteQuiz.name + "?"
        
        let alert = UIAlertController(title: ViewString.HomeDeleteAlertTitle, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: ViewString.HomeDeleteAlertCancel, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: ViewString.HomeDeleteAlertDestructive, style: .destructive, handler: { action in
            
            Storage.shared.removeQuiz(quiz: deleteQuiz)
            self.updateQuizList()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Nav
    
    func navToAddView() {
        let storyBoard = UIStoryboard(name: StoryboardIdentifier.Main, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewIdentifier.AddViewController) as! AddViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    func navToInfoView(_ quiz: Quiz) {
        let storyBoard = UIStoryboard(name: StoryboardIdentifier.Main, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewIdentifier.InfoViewController) as! InfoViewController
        viewController.quiz = quiz
        self.present(viewController, animated: true, completion: nil)
    }
}
