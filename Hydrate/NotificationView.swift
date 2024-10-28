import SwiftUI

struct NotificationView: View {
    @StateObject private var viewModel = NotificationSettingsViewModel() 
    @State private var textAlignment: Alignment = .leading

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
                                Picker("Hour", selection: $viewModel.startHour) {
                                    ForEach(viewModel.hours, id: \.self) { hour in
                                        Text("\(hour)").tag(hour)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 60)
                                
                                Text(":")
                                    .font(.headline)
                                    .padding(.horizontal, 2)
                                Picker("Minute", selection: $viewModel.startMinute) {
                                    ForEach(0..<60, id: \.self) { minute in
                                        Text(String(format: "%02d", minute)).tag(minute)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 60)
                            }

                            Picker("", selection: $viewModel.startPeriod) {
                                ForEach(viewModel.periods, id: \.self) { period in
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
                                Picker("Hour", selection: $viewModel.endHour) {
                                    ForEach(viewModel.hours, id: \.self) { hour in
                                        Text("\(hour)").tag(hour)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 60)
                                
                                Text(":")
                                    .font(.headline)
                                    .padding(.horizontal, 2)
                                Picker("Minute", selection: $viewModel.endMinute) {
                                    ForEach(0..<60, id: \.self) { minute in
                                        Text(String(format: "%02d", minute)).tag(minute)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(width: 60)
                            }
                            Picker("", selection: $viewModel.endPeriod) {
                                ForEach(viewModel.periods, id: \.self) { period in
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
                            ForEach(viewModel.intervals, id: \.1) { interval in
                                Button(action: {
                                    viewModel.selectedInterval = interval.1
                                }) {
                                    Text(interval.0)
                                        .padding(14)
                                        .frame(maxWidth: .infinity)
                                        .background(viewModel.selectedInterval == interval.1 ? Color.cyan : Color.gray.opacity(0.2))
                                        .foregroundColor(viewModel.selectedInterval == interval.1 ? .white : .black)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    Button(action: {
                        viewModel.onNextButtonPressed()
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
                    .navigationDestination(isPresented: $viewModel.isNextPageActive) {
                        Water() // Replace with your next view
                    }

                    Spacer()
                }
                .padding(.top)
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
