//
//  LocationView.swift
//  LocationManagerTest
//
//  Created by Axel Le Pennec on 09/10/2022.
//

import CoreLocation
import SwiftUI

struct LocationView: View {
    let location: CLLocation
    @State private var isExpanded: Bool = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack {
                Group {
                    HStack {
                        Text("Latitude")
                        Spacer()
                        Text(location.coordinate.latitude.formatted())
                    } // HStack
                    
                    HStack {
                        Text("Longitude")
                        Spacer()
                        Text(location.coordinate.longitude.formatted())
                    } // HStack
                    
                    HStack {
                        Text("Horizontal Acc.")
                        Spacer()
                        Text(location.horizontalAccuracy.formatted())
                    } // HStack
                    
                    HStack {
                        Text("Vertical Acc.")
                        Spacer()
                        Text(location.verticalAccuracy.formatted())
                    } // HStack
                    
                    HStack {
                        Text("Speed")
                        Spacer()
                        Text(location.speed.formatted())
                    } // HStack
                } // Group
                
                Group {
                    HStack {
                        Text("Speed Acc.")
                        Spacer()
                        Text(location.speedAccuracy.formatted())
                    } // HStack
                    
                    HStack {
                        Text("Course")
                        Spacer()
                        Text(location.course.formatted())
                    } // HStack
                    
                    HStack {
                        Text("Course Acc.Horizontal Acc.")
                        Spacer()
                        Text(location.courseAccuracy.formatted())
                    } // HStack
                    
                    HStack {
                        Text("Altitude")
                        Spacer()
                        Text(location.altitude.formatted())
                    } // HStack
                    
                    HStack {
                        Text("Ellipsoidal Altitude")
                        Spacer()
                        Text(location.ellipsoidalAltitude.formatted())
                    } // HStack
                }
            } // VStack
            .font(.footnote)
        } label: {
            HStack {
                Text(location.timestamp.formatted(date: .omitted, time: .standard))
                Spacer()
                Text(location.horizontalAccuracy.formatted())
            } // HStack
        } // DisclosureGroup
    } // body
}
