import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource {
    
    public var index: Int?
    public var question: Question?
    private var answerList = [String]()
    
    // MARK: IBOutlet
    
    @IBOutlet weak var numQuestionLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBackground()
        
        guard let infoQuestion = question else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        setupUI(infoQuestion)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        guard let item = getAnswerItem(indexPath) else {
            return cell
        }
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = item
        if question?.index == indexPath.row {
            cell.textLabel?.textColor = UIColor(named: ColourName.Dark)
        } else {
            cell.textLabel?.textColor = UIColor(named: ColourName.Light)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerList.count
    }
    
    // MARK: Table Util
    
    func getAnswerItem(_ indexPath: IndexPath) -> String? {
        
        let index = indexPath.row
        if index < 0 || index >= answerList.count {
            print("failed to get answer item, invalid index")
            return nil
        }
        
        return answerList[index]
    }
    
    // MARK: UI
    
    func updateBackground() {
        
        for subview in self.view.subviews {
            if subview is GradientView {
                subview.removeFromSuperview()
            }
        }
        
        guard let primaryColour = UIColor(named: ColourName.Primary)?.cgColor else {
            return
        }
        
        guard let accentColour = UIColor(named: ColourName.Accent)?.cgColor else {
            return
        }
        
        let gradientView = GradientView(frame: self.view.frame, colours: [accentColour, primaryColour, accentColour], locations: [0.0, 0.5, 1.0])
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(gradientView, at: 0)
    }
    
    func setupUI(_ infoQuestion: Question) {
        
        questionLabel.text = infoQuestion.question
        answerList.append(contentsOf: infoQuestion.answers)
        
        if let infoIndex = index {
            numQuestionLabel.text = String(infoIndex + 1) + ". "
        } else {
            numQuestionLabel.text = ""
        }
        
        answerTableView.dataSource = self
        answerTableView.tableFooterView = UIView()
    }
}
