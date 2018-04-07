import Foundation
import UIKit

class Quiz {
    
    let name: String
    let description: String
    let icon: UIImage
    let questions: [Question]
    // question index
    private var index: Int = 0
    
    init(name: String, description: String, icon: UIImage, questions: [Question]) {
        self.name = name
        self.description = description
        self.icon = icon
        self.questions = questions
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
}
