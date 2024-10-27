import SwiftUI
import UserNotifications

struct NotificationPreferencesView: View {
    @State private var startHour: Int = 3
    @State private var startMinute: Int = 0
    @State private var startPeriod: String = "AM"

    @State private var endHour: Int = 3
    @State private var endMinute: Int = 0
    @State private var endPeriod: String = "AM"

    @State private var selectedInterval: TimeInterval = 1 * 60  // Default to 1 minute

    let hours = Array(1...12)
    let periods = ["AM", "PM"]

    let intervals: [(String, TimeInterval)] = [
        ("1 Minute", 1 * 60),
        ("15 Mins", 15 * 60),
        ("30 Mins", 30 * 60),
        ("60 Mins", 60 * 60),
        ("90 Mins", 90 * 60),
        ("2 Hours", 2 * 60 * 60),
        ("3 Hours", 3 * 60 * 60),
        ("4 Hours", 4 * 60 * 60)
    ]
    
    @State private var textAlignment: Alignment = .leading
    @State private var isNotificationScheduled: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Notification Preferences")
                    .font(.title)
                    .padding(.top, 20)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: textAlignment)

                VStack {
                    Text("The start and End hour")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: textAlignment)

                    Text("Specify the start and end time to receive the notifications")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: textAlignment)

            
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Start hour")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: textAlignment)
                            Spacer()
                            HStack(spacing: -15) {
                                Picker("Hour", selection: $startHour) {
                                    ForEach(hours, id: \.self) { hour in
                                        Text("\(hour)").tag(hour)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 60)
                                
                                Text(":")
                                    .font(.headline)
                                    .padding(.horizontal, 2)
                                Picker("Minute", selection: $startMinute) {
                                    ForEach(0..<60, id: \.self) { minute in
                                        Text(String(format: "%02d", minute)).tag(minute)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 60)
                            }

                            Picker("", selection: $startPeriod) {
                                ForEach(periods, id: \.self) { period in
                                    Text(period).tag(period)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(width: 80)
                        }.padding(.horizontal, 10)
                        
                        Divider()
             
                        HStack {
                            Text("End hour")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: textAlignment)
                            Spacer()
                            HStack(spacing: -15) {
                                Picker("Hour", selection: $endHour) {
                                    ForEach(hours, id: \.self) { hour in
                                        Text("\(hour)").tag(hour)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 60)
                                
                                Text(":")
                                    .font(.headline)
                                    .padding(.horizontal, 2)
                                Picker("Minute", selection: $endMinute) {
                                    ForEach(0..<60, id: \.self) { minute in
                                        Text(String(format: "%02d", minute)).tag(minute)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 60)
                            }
                            Picker("", selection: $endPeriod) {
                                ForEach(periods, id: \.self) { period in
                                    Text(period).tag(period)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(width: 80)
                        }.padding(.horizontal, 10)
                    }
                    .frame(height: 130)
                    .background(Color(.systemGray6))
                    .padding()
                   
              
                    VStack(alignment: .leading) {
                        Text("Notification interval")
                            .font(.headline)
                            .padding(.top, 20)
                            .frame(maxWidth: .infinity, alignment: textAlignment)

                        Text("How often would you like to receive notifications within the specified time interval?")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: textAlignment)

                       
                        LazyVGrid(
                            columns: Array(
                                repeating: GridItem(.flexible(), spacing: 10),
                                count: 4), spacing: 10
                        ) {
                            ForEach(intervals, id: \.1) { interval in
                                Button(action: {
                                    selectedInterval = interval.1
                                }) {
                                    Text(interval.0)
                                        .padding(14)
                                        .frame(maxWidth: .infinity)
                                        .background(
                                            selectedInterval == interval.1
                                                ? Color.cyan
                                                : Color.gray.opacity(0.2)
                                        )
                                        .foregroundColor(
                                            selectedInterval == interval.1
                                                ? .white : .black
                                        )
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

             
                    Button(action: {
                        scheduleNotifications()
                        isNotificationScheduled = true
                    }) {
                        Text("Start")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.cyan)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.top, 30)
                    }
                    .navigationDestination(isPresented: $isNotificationScheduled) {
                        NotificationScheduledView()
                    }

                    Spacer()
                }
                .padding(.top)
            }
            .onAppear(perform: requestNotificationPermission)
        }
    }


    private func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permission granted")
            } else if let error = error {
                print("Error requesting permission: \(error)")
            }
        }
    }

  
    private func scheduleNotifications() {
        let center = UNUserNotificationCenter.current()
        
 
        var components = DateComponents()
        components.calendar = Calendar.current
        
        let startHour24 = (startPeriod == "PM" && startHour != 12) ? startHour + 12 : (startPeriod == "AM" && startHour == 12) ? 0 : startHour
        components.hour = startHour24
        components.minute = startMinute
        
        let startDate = Calendar.current.date(from: components) ?? Date()
        

        var endComponents = DateComponents()
        endComponents.calendar = Calendar.current
        let endHour24 = (endPeriod == "PM" && endHour != 12) ? endHour + 12 : (endPeriod == "AM" && endHour == 12) ? 0 : endHour
        endComponents.hour = endHour24
        endComponents.minute = endMinute
        
        let endDate = Calendar.current.date(from: endComponents) ?? Date()

       
        var currentDate = startDate
        while currentDate <= endDate {
            let content = UNMutableNotificationContent()
            content.title = "Time to Hydrate!"
            content.body = "It's time to drink water."
            content.sound = UNNotificationSound.default

           
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: currentDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

           
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request) { error in
                if let error = error {
                    print("Error adding notification: \(error)")
                }
            }

            
            currentDate.addTimeInterval(selectedInterval)
        }
    }
}

struct NotificationScheduledView: View {
    var body: some View {
        VStack {
            Text("Notifications Scheduled!")
                .font(.largeTitle)
                .padding()

            Text("You will receive notifications according to your preferences.")
                .font(.subheadline)
                .padding()
        }
        .navigationTitle("Confirmation")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NotificationPreferencesView_Previews: PreviewProvider  {
    static var previews: some View  {
        NotificationPreferencesView()
    }
}
