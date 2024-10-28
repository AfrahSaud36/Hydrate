import SwiftUI

struct Water: View {
    @StateObject private var viewModel = WaterViewModel() // Initialize the ViewModel

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white.edgesIgnoringSafeArea(.all) // Background color
            
            VStack(spacing: 20) {
                // Circle showing water intake progress
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .foregroundColor(Color.gray.opacity(0.3))
                    
                    Circle()
                        .trim(from: 0.0, to: min(CGFloat(viewModel.waterIntake / viewModel.dailyGoal), 1.0))
                        .stroke(Color.cyan, lineWidth: 20)
                        .rotationEffect(Angle(degrees: -90))
                        .animation(.easeInOut, value: viewModel.waterIntake)

                    Image(systemName: viewModel.currentIcon) // Icon based on water intake
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                }
                .frame(width: 250, height: 250)
                
                Text("\(String(format: "%.1f", viewModel.waterIntake)) L") // Display water intake
                    .font(.title)
                    .bold()
                
                Stepper(value: $viewModel.waterIntake, in: 0...viewModel.dailyGoal, step: 0.675) {
                    // Empty label since we are only updating the value
                }
                .padding()
                .offset(y: 99)
                .offset(x: -110)
                
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Today's water intake label and value
            VStack(alignment: .leading) {
                Text("Today's Water Intake")
                    .font(.headline)
                    .padding(.top, 40)
                    .padding(.leading, 20)
                    .foregroundColor(Color.gray)
                
                Text("\(String(format: "%.1f", viewModel.waterIntake)) liter / \(String(format: "%.1f", viewModel.dailyGoal)) liter")
                    .font(.title2)
                    .bold()
                    .padding(.leading, 20)
                    .foregroundColor(viewModel.waterIntake >= viewModel.dailyGoal ? Color.green : Color.primary)
            }
        }
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        Water() // Preview the Water view
    }
}
