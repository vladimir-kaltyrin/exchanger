import Foundation

final class MockUserDataStorageImpl: NSObject, UserDataStorage {
    
    private var user: User?
    
    func save(_ user: User) {
        self.user = user
    }
    
    func user(_ onUser: ((User?) -> ())?) {
        onUser?(self.user)
    }

}
