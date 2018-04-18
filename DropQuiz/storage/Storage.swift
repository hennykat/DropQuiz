import Foundation

class Storage {
    
    static let shared = Storage()
    
    private let quizListPath: String
    
    init() {
        let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        quizListPath = DocumentsDirectory.appendingPathComponent(DocumentPath.QuizListFile).path
    }
    
    public func addQuiz(quiz: Quiz) {
        var quizList = loadQuizList() ?? [Quiz]()
        quizList.append(quiz)
        saveQuizList(quizList: quizList)
    }
    
    public func removeQuiz(quiz: Quiz) {
        
        var quizList = loadQuizList() ?? [Quiz]()
        var count = 0
        
        for item in quizList {
            if item.isEqual(quiz) {
                quizList.remove(at: count)
                break
            }
            
            count += 1
        }
        saveQuizList(quizList: quizList)
    }
    
    public func saveQuizList(quizList: [Quiz]) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(quizList, toFile: quizListPath)
        if !isSuccessfulSave {
            print("failed to save quizzes")
        }
    }
    
    public func loadQuizList() -> [Quiz]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: quizListPath) as? [Quiz]
    }
}
