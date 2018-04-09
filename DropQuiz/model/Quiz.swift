import Foundation
import UIKit

struct QuizKey {
    static let name = "name"
    static let description = "description"
    static let icon = "icon"
    static let questions = "questions"
}

class Quiz: NSCoding {
    
    let name: String
    let description: String?
    let icon: UIImage?
    let questions: [Question]
    // question index
    private var index: Int = 0
    
    init(name: String, description: String?, icon: UIImage?, questions: [Question]) {
        self.name = name
        self.description = description
        self.icon = icon
        self.questions = questions
    }
    
    convenience init(name: String, icon: UIImage?) {
        self.init(name: name, description: nil, icon: icon, questions: [Question]())
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
        aCoder.encode(description, forKey: QuizKey.description)
        aCoder.encode(icon, forKey: QuizKey.icon)
        aCoder.encode(questions, forKey: QuizKey.questions)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObject(forKey: QuizKey.name) as? String ?? ""
        let description = aDecoder.decodeObject(forKey: QuizKey.description) as? String
        let icon = aDecoder.decodeObject(forKey: QuizKey.icon) as? UIImage
        let questions = aDecoder.decodeObject(forKey: QuizKey.questions) as? [Question] ?? [Question]()
        
        self.init(name: name, description: description, icon: icon, questions: questions)
    }
}
