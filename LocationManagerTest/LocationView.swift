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
                LabeledContent("Latitude", value: location.coordinate.latitude.formatted())
                LabeledContent("Longitude", value: location.coordinate.longitude.formatted())
                LabeledContent("Horizontal Acc.", value: location.horizontalAccuracy.formatted())
                LabeledContent("Vertical Acc.", value: location.verticalAccuracy.formatted())
                LabeledContent("Speed", value: location.speed.formatted())
                
                Group {
                    LabeledContent("Speed Acc.", value: location.speedAccuracy.formatted())
                    LabeledContent("Course", value: location.course.formatted())
                    LabeledContent("Course Acc.", value: location.courseAccuracy.formatted())
                    LabeledContent("Altitude", value: location.altitude.formatted())
                    LabeledContent("Ellipsoidal Altitude", value: location.ellipsoidalAltitude.formatted())
                }
            } // VStack
            .font(.footnote)
        } label: {
            LabeledContent(location.timestamp.formatted(date: .omitted, time: .standard), value: location.horizontalAccuracy.formatted())
        } // DisclosureGroup
    } // body
}
