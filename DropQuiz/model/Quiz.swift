import Foundation
import UIKit

struct QuizKey {
    static let name = "name"
    static let information = "information"
    static let icon = "icon"
    static let questions = "questions"
}

class Quiz: NSObject, NSCoding {
    
    let name: String
    // description for quiz (description keyword taken)
    let information: String?
    let icon: UIImage?
    var questions: [Question]
    // question index
    private var index: Int = 0
    
    init(name: String, information: String?, icon: UIImage?, questions: [Question]) {
        self.name = name
        self.information = information
        self.icon = icon
        self.questions = questions
    }
    
    convenience init(name: String, icon: UIImage?) {
        self.init(name: name, information: nil, icon: icon, questions: [Question]())
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        guard let quiz = object as? Quiz else {
            return false
        }
        
        if quiz.name != self.name || quiz.information != self.information {
            return false
        }
        
        if quiz.icon != self.icon {
            return false
        }
        
        if quiz.questions.count != self.questions.count {
            return false
        }
        
        for (question1, question2) in zip(quiz.questions, self.questions) where !(question1.isEqual(question2))  {
            return false
        }
        
        return true
    }
    
    func getCurrentQuestion() -> Question? {
        
        if index < 0 || index >= questions.count {
            return nil
        }
        
        return questions[index]
    }
    
    func getQuestionNumber() -> String {
        return String(index + 1)
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: QuizKey.name)
        aCoder.encode(information, forKey: QuizKey.information)
        aCoder.encode(icon, forKey: QuizKey.icon)
        aCoder.encode(questions, forKey: QuizKey.questions)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObject(forKey: QuizKey.name) as? String ?? ""
        let information = aDecoder.decodeObject(forKey: QuizKey.information) as? String
        let icon = aDecoder.decodeObject(forKey: QuizKey.icon) as? UIImage
        let questions = aDecoder.decodeObject(forKey: QuizKey.questions) as? [Question] ?? [Question]()
        
        self.init(name: name, information: information, icon: icon, questions: questions)
    }
}
