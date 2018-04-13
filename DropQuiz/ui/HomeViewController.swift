import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var quizList = [Quiz]()
    
    // MARK: IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBackground()
        
        collectionView.register(UINib(nibName: ViewIdentifier.HomeQuizCell, bundle: nil), forCellWithReuseIdentifier: ViewIdentifier.HomeQuizCell)
        collectionView.delegate = self
        collectionView.dataSource = self
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
        
        if let item = getQuizItem(indexPath) {
            navToInfoView(item)
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewIdentifier.HomeQuizCell, for: indexPath) as! HomeQuizCell
        
        guard let item = getQuizItem(indexPath) else {
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
        let testQuestion2 = Question(question: "What is green?", answers: ["tomato", "onion", "lettuce", "nuts"], index: 2)
        let testQuestion3 = Question(question: "What is food?", answers: ["grass", "dirt", "rocks", "sushi"], index: 3)
        let testQuiz = Quiz(name: "test", description: "this is a test quiz", icon: UIImage(named: ImageName.Default), questions: [Question]())
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
    
    func getQuizItem(_ indexPath: IndexPath) -> Quiz? {
        
        let index = indexPath.row
        if index < 0 || index >= quizList.count {
            print("failed to get quiz item, invalid index")
            return nil
        }
        
        return quizList[index]
    }
    
    // MARK: UI
    
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
