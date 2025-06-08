//
//  MapViewWithSearch.swift
//  renewIt(final)
//
//  Created by Raeva Desai on 6/8/25.
//
import SwiftUI
import MapKit

// Required for onChange with CLLocationCoordinate2D
extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct MapViewWithSearch: View {
    @Binding var selectedCategory: String?
    @StateObject private var locationManager = LocationManager()
    @State private var searchText = ""
    @State private var pins: [PinnedLocation] = allPins
    @State private var selectedPin: PinnedLocation?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.3352, longitude: -121.8811),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State private var showBottomSheet = true

    var body: some View {
        ZStack(alignment: .bottom) {
            // Map with custom, color-coded pins
            Map(
                coordinateRegion: $region,
                showsUserLocation: true,
                annotationItems: pins
            ) { pin in
                MapAnnotation(coordinate: pin.coordinate) {
                    Button(action: {
                        withAnimation {
                            selectedPin = pin
                            region.center = pin.coordinate
                            region.span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                        }
                    }) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(colorForCategory(pin: pin))
                            .shadow(radius: 2)
                    }
                }
            }
            .ignoresSafeArea(.keyboard)

            // Search bar at the top
            VStack(spacing: 0) {
                HStack {
                    TextField("Search (e.g. metal, clothes, recycling)", text: $searchText, onCommit: search)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading)
                    Button(action: search) {
                        Image(systemName: "magnifyingglass")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.trailing)
                }
                .padding(.top)
                .background(Color(UIColor.systemBackground).opacity(0.95))
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)

                Spacer()
            }

            // Bottom sheet for locations
            if showBottomSheet {
                VStack(spacing: 0) {
                    // Handle for dragging
                    RoundedRectangle(cornerRadius: 3)
                        .frame(width: 40, height: 5)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.top, 8)
                    
                    // Locations list
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(spacing: 8) {
                            ForEach(pins.sorted(by: { ($0.distanceFromUser ?? 0) < ($1.distanceFromUser ?? 0) })) { pin in
                                Button(action: {
                                    withAnimation {
                                        selectedPin = pin
                                        region.center = pin.coordinate
                                        region.span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "mappin.circle.fill")
                                            .font(.system(size: 20))
                                            .foregroundColor(colorForCategory(pin: pin))
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(pin.name)
                                                .font(.body)
                                                .foregroundColor(.primary)
                                            if let distance = pin.distanceFromUser {
                                                Text("\(String(format: "%.1f", distance)) km")
                                                    .font(.caption)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding(12)
                                    .background(Color(UIColor.secondarySystemBackground))
                                    .cornerRadius(10)
                                    .shadow(radius: 2)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: 300)
                    .padding(.bottom, 8)
                }
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(16, corners: [.topLeft, .topRight])
                .shadow(radius: 10)
                .padding(.horizontal, 8)
                .gesture(
                    DragGesture(minimumDistance: 20, coordinateSpace: .local)
                        .onEnded { value in
                            if value.translation.height > 50 {
                                withAnimation {
                                    showBottomSheet = false
                                }
                            }
                        }
                )
            } else {
                // Small button to show the bottom sheet again
                Button(action: {
                    withAnimation {
                        showBottomSheet = true
                    }
                }) {
                    Image(systemName: "chevron.up.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.green)
                        .padding(8)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                .padding(.bottom, 16)
            }

            // Pin info popup (above bottom sheet)
            if let pin = selectedPin {
                VStack(alignment: .leading, spacing: 8) {
                    Text(pin.name)
                        .font(.headline)
                    Text(pin.address)
                        .font(.subheadline)
                    Text("Open: \(pin.openHours)")
                        .font(.subheadline)
                    Text(pin.description)
                        .font(.footnote)
                    if let distance = pin.distanceFromUser {
                        Text("Distance: \(String(format: "%.1f", distance)) km")
                            .font(.subheadline)
                    }
                    // Directions button to open Google Maps
                    Button(action: {
                        let googleMapsURL = "https://www.google.com/maps/dir/?api=1&destination=\(pin.coordinate.latitude),\(pin.coordinate.longitude)"
                        if let url = URL(string: googleMapsURL) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.triangle.turn.up.right.diamond.fill")
                            Text("Directions")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
                .padding(.bottom, showBottomSheet ? 320 : 80)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .onTapGesture {
                    withAnimation {
                        selectedPin = nil
                    }
                }
            }
        }
        .onAppear {
            print("Number of pins:", pins.count) // Debug: Check pins count
            if let userLoc = locationManager.userLocation {
                region.center = userLoc
                updateDistances(userLocation: userLoc)
            } else {
                locationManager.requestPermission()
            }
        }
        .onChange(of: locationManager.userLocation) { userLoc in
            if let userLoc = userLoc {
                updateDistances(userLocation: userLoc)
            }
        }
        .onChange(of: selectedCategory) { _ in
            if let category = selectedCategory {
                searchText = "\(category) donation"
                search()
            }
        }
    }

    // MARK: - Helper functions

    func search() {
        pins = allPins.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.description.lowercased().contains(searchText.lowercased()) }
        if let userLoc = locationManager.userLocation {
            updateDistances(userLocation: userLoc)
        }
    }

    func updateDistances(userLocation: CLLocationCoordinate2D) {
        let userCLLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        for i in 0..<pins.count {
            let pinCLLocation = CLLocation(latitude: pins[i].coordinate.latitude, longitude: pins[i].coordinate.longitude)
            pins[i].distanceFromUser = userCLLocation.distance(from: pinCLLocation) / 1000 // km
        }
    }

    func colorForCategory(pin: PinnedLocation) -> Color {
        let name = pin.name.lowercased()
        let description = pin.description.lowercased()

        if name.contains("clothes") || name.contains("shoes") || name.contains("thrift") ||
           description.contains("clothes") || description.contains("shoes") || description.contains("thrift") {
            return Color.pink
        } else if name.contains("metal") || description.contains("metal") {
            return Color.orange
        } else if name.contains("garbage") || name.contains("recycling") || name.contains("trash") ||
                  description.contains("garbage") || description.contains("recycling") || description.contains("trash") {
            return Color.green
        }
        return Color.red
    }
}

// For rounded corners on top only
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
