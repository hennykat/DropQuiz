import UIKit

class UIUtil {
    
    static func getListItem<T>(at indexPath: IndexPath, _ itemList: [T], defaultItem: T? = nil) -> T? {
        
        let index = indexPath.row
        if index < 0 || index >= itemList.count {
            print("failed to get list item, invalid index")
            return defaultItem
        }
            
        return itemList[index]
    }
}
