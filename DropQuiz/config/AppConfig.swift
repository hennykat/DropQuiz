import Foundation

class StoryboardIdentifier {
    static let Main = "Main"
}

class ViewIdentifier {
    static let HomeViewController = "HomeViewController"
    static let HomeQuizCell = "HomeQuizCell"
    static let AddViewController = "AddViewController"
    static let IconPickerViewController = "IconPickerViewController"
    static let IconImageCell = "IconImageCell"
    static let InfoViewController = "InfoViewController"
    static let InfoQuestionCell = "InfoQuestionCell"
    static let QuestionViewController = "QuestionViewController"
    static let QuizViewController = "QuizViewController"
}

class ImageName {
    // util icons
    static let Add = "add"
    static let X = "x"
    static let Check = "check"
    static let Default = "default"
    static let Start = "start"
    // quiz icons
    static let Star = "star"
    static let Heart = "heart"
    static let World = "world"
    static let Art = "art"
    static let Animal = "animal"
    static let Food = "food"
    static let Money = "money"
}

class ColourName {
    static let Dark = "dark"
    static let Light = "light"
    static let Primary = "primary"
    static let Secondary = "secondary"
    static let Accent = "accent"
}

class DocumentPath {
    static let QuizListFile = "quizList"
}

class ViewString {
    static let HomeAdd = NSLocalizedString("home_add", comment: "")
    
    static let AddName = NSLocalizedString("add_name", comment: "")
    static let AddDescription = NSLocalizedString("add_description", comment: "")
    static let AddSaveAlertTitle = NSLocalizedString("add_save_alert_title", comment: "")
    static let AddSaveAlertMsg = NSLocalizedString("add_save_alert_msg", comment: "")
    static let AddSaveAlertDefault = NSLocalizedString("add_save_alert_default", comment: "")
    static let AddSaveAlertCancel = NSLocalizedString("add_save_alert_cancel", comment: "")
    static let AddCancelAlertTitle = NSLocalizedString("add_cancel_alert_title", comment: "")
    static let AddCancelAlertMsg = NSLocalizedString("add_cancel_alert_msg", comment: "")
    static let AddCancelAlertCancel = NSLocalizedString("add_cancel_alert_cancel", comment: "")
    static let AddCancelAlertDestructive = NSLocalizedString("add_cancel_alert_destructive", comment: "")
    
    static let InfoQuestion = NSLocalizedString("info_question", comment: "")
    static let InfoQuestions = NSLocalizedString("info_questions", comment: "")
}
