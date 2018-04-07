import Foundation

class Question {

    let question: String
    let answers: [String]
    // index of correct answer
    let index: Int = 0
    // not yet supported
    let hint: String?
    
    init(question: String, answers: [String], hint: String?) {
        self.question = question
        self.answers = answers
        self.hint = hint
    }
    
    convenience init(question: String, answers: [String]) {
        self.init(question: question, answers: answers, hint: nil)
    }
    
}
