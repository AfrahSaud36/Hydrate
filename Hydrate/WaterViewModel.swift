import SwiftUI
import Combine

// ViewModel
class WaterViewModel: ObservableObject {
    @Published var waterIntake: Double = 0.0
    let dailyGoal: Double = 2.7
    
    var currentIcon: String {
        switch waterIntake {
        case 0.0:
            return "zzz"
        case 0.1..<0.9:
            return "tortoise"
        case 0.9..<2.7:
            return "hare"
        default:
            return "hands.clap"
        }
    }
}
