import SwiftUI

struct Water: View {
    @State private var waterIntake: Double = 0.0
    private let dailyGoal: Double = 2.7

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

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
             
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .foregroundColor(Color.gray.opacity(0.3))
                    
                    Circle()
                        .trim(from: 0.0, to: min(CGFloat(waterIntake / dailyGoal), 1.0))
                        .stroke(Color.cyan, lineWidth: 20)
                        .rotationEffect(Angle(degrees: -90))
                        .animation(.easeInOut, value: waterIntake)

                    Image(systemName: currentIcon)
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                }
                .frame(width: 250, height: 250)
                
                Text("\(String(format: "%.1f", waterIntake)) L")
                    .font(.title)
                    .bold()
                
                Stepper(value: $waterIntake, in: 0...dailyGoal, step: 0.675) {

                }
                .padding()
                .offset(y: 99)
                .offset(x: -110)
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            VStack(alignment: .leading) {
                Text("Today's Water Intake")
                    .font(.headline)
                    .padding(.top, 40)
                    .padding(.leading, 20)
                    .foregroundColor(Color.gray)
                
                Text("\(String(format: "%.1f", waterIntake)) liter / \(String(format: "%.1f", dailyGoal)) liter")
                    .font(.title2)
                    .bold()
                    .padding(.leading, 20)
                    .foregroundColor(waterIntake >= dailyGoal ? Color.green : Color.primary)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Water()
    }
}
