import Foundation

class Storage {
    
    static let shared = Storage()
    
    private let quizListPath: String
    
    init() {
        let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        quizListPath = DocumentsDirectory.appendingPathComponent(DocumentPath.QuizListFile).path
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
