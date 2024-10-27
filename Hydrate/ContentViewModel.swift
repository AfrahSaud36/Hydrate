import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var bodyWeight: String = ""

    func clearBodyWeight() {
        bodyWeight = ""
    }
}
