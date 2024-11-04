<h1 align="center">Hydrate 💧 </h1>


Hydrate is a simple SwiftUI app designed to help you track your daily water intake based on your individual needs. Stay hydrated by recording and monitoring your water consumption to meet your daily goal!

## Features

- **Daily Water Tracking**: Log your body weight, calculate your daily hydration needs, and track your progress.
- **User-Friendly Interface**: A clean and intuitive UI designed with Apple's design standards.
- **Navigation**: Smooth transitions between different views for an enhanced user experience.

## Screenshots

<img src="https://github.com/user-attachments/assets/b734597a-b4e1-459b-b29d-ecf8d0a03059" alt="App Screenshot" width="300"/>
<img src="https://github.com/user-attachments/assets/e63d9232-24e3-41d5-bcba-14d0fa264e28" alt="App Screenshot" width="300"/>
<img src="https://github.com/user-attachments/assets/8df57b05-6b7b-4a2f-acd2-9ea991be553c" alt="App Screenshot" width="300"/>


### Try It

1. Open the project in Xcode.
2. Select your target device or simulator.
3. Build and run the app.

## Technologies Used

- **Swift** – Language used for app development.
- **SwiftUI** – Framework for building the user interface.
- **Xcode** – Development environment.
- **MVVM Design Pattern** – For code organization and separation of concerns.
  
## Future Enhancements

Some ideas for future updates to enhance the functionality and user experience:

- **Customizable Reminders**: Set specific intervals for hydration reminders.
- **Data Analytics**: Track hydration over time with charts and summaries.
- **Widgets**: Include home screen widgets to easily track water intake.

## Usage

1. Launch the app.
2. Enter your body weight in the provided text field.
3. Click "Next" to navigate to the notification settings and set your hydration reminders (functionality can be expanded here).
4. Monitor your progress on the Water view to ensure you meet your daily hydration goal.

## Project Structure

Here's a breakdown of the main files and their purposes:

- **ContentView** – Main screen where users enter their body weight and see the app's introduction.
- **NotificationView** – View where users can manage notification settings for hydration reminders.
- **Water** – Tracks and displays the user’s progress toward their daily hydration goal.

## Code Overview

### ContentView

This is the main view of the Hydrate app, where users can:

- Enter their body weight, which is used to calculate their hydration goal.
- Clear the body weight input if needed.
- Navigate to the next screen for notification settings.

     ```swift
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
                                    

## Acknowledgements

This project was made possible with the support and resources from:

- **Apple Developer Academy** – for providing guidance, mentorship, and resources in iOS development and UI/UX standards.
- **SwiftUI Documentation** – for offering detailed and helpful resources for developing with SwiftUI.
- **GitHub Community** – for providing valuable insights and code-sharing platforms to enhance development.
