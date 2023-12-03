import Foundation

public class Storage {
    static func isFirstTime() -> Bool {
        let defaults = UserDefaults.standard

        if defaults.object(forKey: "first") == nil {
            defaults.set("No", forKey: "first")
            return true
        } else {
            return false
        }
    }
}
