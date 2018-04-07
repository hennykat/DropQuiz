import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var quizList = [Quiz]()
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: ViewIdentifiers.HomeQuizCell, bundle: nil), forCellWithReuseIdentifier: ViewIdentifiers.HomeQuizCell)
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
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        // TODO
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewIdentifiers.HomeQuizCell, for: indexPath) as! HomeQuizCell
        
        guard let item = getQuizItem(indexPath) else {
            return cell
        }
        
        cell.nameLabel.text = item.name
        cell.iconImageView.image = item.icon
        
        return cell
    }
    
    // MARK: Util
    
    func updateQuizList() {
        
        // TODO: load quizzes
        
        let addQuiz = makeAddQuiz()
        quizList.append(addQuiz)
        collectionView.reloadData()
    }
    
    func makeAddQuiz() -> Quiz {
        return Quiz(name: "add", icon: UIImage(named: "add")!)
    }
    
    func getQuizItem(_ indexPath: IndexPath) -> Quiz? {
        
        let index = indexPath.row
        if index < 0 || index >= quizList.count {
            print("failed to get quiz item, invalid index")
            return nil
        }
        
        return quizList[index]
    }
}
