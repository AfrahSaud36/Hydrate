import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer(minLength: 20)
                
                Image("drop")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.tint)
                    .padding()
                
                Text("Hydrate")
                    .font(.system(size: 30, weight: .bold))
                    .padding(15)
                
                Text("Start with Hydrate record and track your water intake daily based on your needs and stay hydrated")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                ZStack(alignment: .trailing) {
                    HStack {
                        Text("Body Weight")
                            .padding()
                        Spacer()
                    }
                    TextField("Value", text: $viewModel.bodyWeight)
                        .padding(.leading, 125)
                        .padding(.vertical, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(2)
                    
                    Button(action: {
                        viewModel.clearBodyWeight()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(10)
                    }
                    .padding(.trailing, 20)
                }
                .padding(.top, 5)
                
                Spacer()
                
                NavigationLink(destination: NotificationView()) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.192, green: 0.68, blue: 0.903))
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                        .padding(.bottom)
                }
            }
            .padding(.top, -170)
            .padding()
        }
    }
}

struct NextView: View {
    var body: some View {
        Text("This is the Next View")
            .font(.largeTitle)
            .padding()
    }
}

#Preview {
    ContentView()
}
