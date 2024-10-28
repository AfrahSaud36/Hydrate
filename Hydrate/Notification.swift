import SwiftUI

struct NotificationPreferencesView: View {
    @State private var startHour: Int = 3
    @State private var startMinute: Int = 0
    @State private var startPeriod: String = "AM"

    @State private var endHour: Int = 3
    @State private var endMinute: Int = 0
    @State private var endPeriod: String = "AM"

    @State private var selectedInterval: TimeInterval = 15 * 60  // Default to 15 minutes

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
    
    @State private var textAlignment: Alignment = .leading
    @State private var isNextPageActive: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Notification Preferences")
                    .font(.title)
                    .padding(.top, 0)
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
                        // Start time pickers
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
             
                        // End time pickers
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
                            columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10
                        ) {
                            ForEach(intervals, id: \.1) { interval in
                                Button(action: {
                                    selectedInterval = interval.1
                                }) {
                                    Text(interval.0)
                                        .padding(14)
                                        .frame(maxWidth: .infinity)
                                        .background(selectedInterval == interval.1 ? Color.cyan : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedInterval == interval.1 ? .white : .black)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    Button(action: {
                        isNextPageActive = true
                    }) {
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.cyan)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.top, 20)
                    }
                    .navigationDestination(isPresented: $isNextPageActive) {
                        Water()
                    }

                    Spacer()
                }
                .padding(.top)
            }
        }
    }
}

struct NotificationPreferencesView_Previews: PreviewProvider  {
    static var previews: some View  {
        NotificationPreferencesView()
    }
}
