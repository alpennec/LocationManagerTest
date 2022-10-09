//
//  ContentView.swift
//  Skipper
//
//  Created by Axel Le Pennec on 06/10/2022.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    @StateObject private var locationDataManager: LocationDataManager = LocationDataManager()
    
    var body: some View {
        List {
            /// To configure the location manager
            Section {
                Picker("Activity Type", selection: $locationDataManager.activityType) {
                    Text("Automotive").tag(CLActivityType.automotiveNavigation)
                    Text("Other Navigation").tag(CLActivityType.otherNavigation)
                    Text("Fitness").tag(CLActivityType.fitness)
                    Text("Airborne").tag(CLActivityType.airborne)
                    Text("Other").tag(CLActivityType.other)
                } // Picker
                
                Picker("Desired Accuracy", selection: $locationDataManager.desiredAccuracy) {
                    Text("Navigation").tag(kCLLocationAccuracyBestForNavigation)
                    Text("Best").tag(kCLLocationAccuracyBest)
                    Text("Ten Meters").tag(kCLLocationAccuracyNearestTenMeters)
                    Text("Hundred Meters").tag(kCLLocationAccuracyHundredMeters)
                    Text("Kilometer").tag(kCLLocationAccuracyKilometer)
                    Text("Three Kilometers").tag(kCLLocationAccuracyThreeKilometers)
                } // Picker
                
                Toggle("Auto pause", isOn: $locationDataManager.pausesLocationUpdatesAutomatically)
                    .tint(.accentColor)
                
                Stepper(value: $locationDataManager.distanceFilter, in: -1...100, step: 1) {
                    HStack {
                        Text("Distance Filter")
                        Spacer()
                        Text(locationDataManager.distanceFilter.formatted())
                    } // HStack
                } // Stepper
            } // Section
            .disabled(locationDataManager.isUpdating)
            
            /// To start and stop the location managed
            Section {
                Button(locationDataManager.isUpdating ? "Stop" : "Start") {
                    if locationDataManager.isUpdating {
                        locationDataManager.stop()
                    } else {
                        locationDataManager.start()
                    }
                } // Button
            } // Section
            
            /// To know when locationManagerDidPauseLocationUpdates or locationManagerDidResumeLocationUpdates were called.
            if !locationDataManager.messages.isEmpty {
                Section {
                    ForEach(locationDataManager.messages, id:\.self) { message in
                        Text(message)
                    } // ForEach
                } // Section
            }
            
            
            /// To display all locations with details
            Section {
                Text(String(locationDataManager.allLocations.count))
                ForEach(locationDataManager.allLocations, id:\.timestamp) { location in
                    LocationView(location: location)
                } // ForEach
            } // Section
        } // List
    } // body
}

struct RecordTest_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


