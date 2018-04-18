import Foundation

struct QuestionKey {
    static let question = "question"
    static let answers = "answers"
    static let index = "index"
    static let hint = "hint"
}

class Question: NSObject, NSCoding {

    let question: String
    let answers: [String]
    // index of correct answer
    let index: Int
    // not yet supported
    let hint: String?
    
    init(question: String, answers: [String], index: Int, hint: String?) {
        self.question = question
        self.answers = answers
        self.index = index
        self.hint = hint
    }
    
    convenience init(question: String, answers: [String], index: Int) {
        self.init(question: question, answers: answers, index: index, hint: nil)
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(question, forKey: QuestionKey.question)
        aCoder.encode(answers, forKey: QuestionKey.answers)
        aCoder.encode(index, forKey: QuestionKey.index)
        aCoder.encode(hint, forKey: QuestionKey.hint)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let question = aDecoder.decodeObject(forKey: QuestionKey.question) as? String ?? ""
        let answers = aDecoder.decodeObject(forKey: QuestionKey.answers) as? [String] ?? [String]()
        let index = aDecoder.decodeObject(forKey: QuestionKey.index) as? Int ?? 0
        let hint = aDecoder.decodeObject(forKey: QuestionKey.hint) as? String
        
        self.init(question: question, answers: answers, index: index, hint: hint)
    }
    
}
