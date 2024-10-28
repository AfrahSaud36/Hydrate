import SwiftUI
import Combine

class NotificationSettingsViewModel: ObservableObject {
    // Published properties for binding
    @Published var startHour: Int = 3
    @Published var startMinute: Int = 0
    @Published var startPeriod: String = "AM"
    @Published var endHour: Int = 3
    @Published var endMinute: Int = 0
    @Published var endPeriod: String = "AM"
    @Published var selectedInterval: TimeInterval = 15 * 60  // Default to 15 minutes
    @Published var isNextPageActive: Bool = false
    
    let hours = Array(1...12)
    let periods = ["AM", "PM"]
    let intervals: [(String, TimeInterval)] = [
        ("15 Mins", 15 * 60),
        ("30 Mins", 30 * 60),
        ("60 Mins", 60 * 60),
        ("90 Mins", 90 * 60),
        ("2 Hours", 2 * 60 * 60),
        ("3 Hours", 3 * 60 * 60),
        ("4 Hours", 4 * 60 * 60),
        ("5 Hours", 5 * 60 * 60)
    ]

    func onNextButtonPressed() {
        isNextPageActive = true
    }
}
