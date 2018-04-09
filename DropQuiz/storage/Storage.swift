import Foundation

class Storage {
    
    static let shared = Storage()
    
    private let archiveURL: URL
    
    init() {
        let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        archiveURL = DocumentsDirectory.appendingPathComponent(DocumentPath.QuizListFile)
    }
    
    public func saveQuizList(quizList: [Quiz]) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(quizList, toFile: archiveURL.path)
        if !isSuccessfulSave {
            print("failed to save quizzes")
        }
    }
    
    public func loadQuizList() -> [Quiz]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? [Quiz]
    }
}
