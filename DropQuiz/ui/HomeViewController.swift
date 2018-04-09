import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var quizList = [Quiz]()
    
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
    
    // MARK: Util
    
    func updateQuizList() {
        
        quizList.removeAll()
        collectionView.reloadData()
        
        if let quizzes = Storage.shared.loadQuizList() {
            quizList.append(contentsOf: quizzes)
        }
        
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
        
        let gradientView = GradientView(frame: self.view.frame, colours: [darkColour, secondaryColour])
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(gradientView, at: 0)
    }
    
    // MARK: Navigation
    
    func navToAddView() {
        let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardIdentifier.Main, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewIdentifier.AddViewController) as! AddViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    func navToInfoView(_ quiz: Quiz) {
    
    }
}
