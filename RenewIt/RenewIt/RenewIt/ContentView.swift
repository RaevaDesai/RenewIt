import SwiftUI
import CoreLocation
import MapKit

// MARK: - Helper Functions

func getDisposalTechnique(for category: String) -> String {
    switch category {
    case "battery":
        return "Take to a battery recycling center. Do not throw in regular trash as batteries can leak harmful chemicals."
    case "biological":
        return "Compost if possible. If not, dispose in green waste or check local composting programs."
    case "cardboard":
        return "Flatten and recycle in paper or cardboard bins. Remove any tape or labels if possible."
    case "clothes":
        return "Donate to thrift stores or charities if in good condition. Otherwise, recycle textiles at a local facility."
    case "glass":
        return "Recycle in glass bins. Rinse containers before recycling."
    case "metal":
        return "Recycle in metal bins. Consider donating to robotics labs or makerspaces if the item is usable."
    case "paper":
        return "Recycle in paper bins. Remove any plastic or non-paper components first."
    case "plastic":
        return "Check local guidelines for plastic recycling. Rinse containers before recycling."
    case "shoes":
        return "Donate to charities or thrift stores if in good condition. Otherwise, recycle at a textile recycling facility."
    case "trash":
        return "Dispose in regular trash. If unsure, check local waste guidelines."
    default:
        return "Check local waste management guidelines for proper disposal."
    }
}

// MARK: - Location Manager

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location.coordinate
    }
}

// MARK: - Start Scanning View

struct StartScanningView: View {
    @Binding var selectedTab: Int
    @Binding var selectedCategory: String?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var classificationResult: String?
    @State private var disposalTechnique: String?
    
    var body: some View {
        VStack {
            if inputImage != nil {
                Image(uiImage: inputImage!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                if let result = classificationResult {
                    Text("Detected: \(result)")
                        .font(.title2)
                        .padding()
                    if let technique = disposalTechnique {
                        Text("Disposal: \(technique)")
                            .font(.title3)
                            .foregroundColor(.secondary)
                            .padding()
                        // If clothes, shoes, or metal, show a button to go to map
                        if result == "clothes" || result == "shoes" || result == "metal" {
                            Button(action: {
                                selectedCategory = result
                                selectedTab = 2 // Switch to map tab
                            }) {
                                Text("Find Donation Locations")
                                    .font(.title3)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(15)
                            }
                            .padding()
                        }
                    }
                }
            } else {
                Text("Take a picture to scan!")
                    .font(.title)
                    .padding()
            }
            Spacer()
            Button(action: {
                showingImagePicker = true
            }) {
                Text("Start Scanning")
                    .font(.title)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .padding(.bottom, 40)
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: classifyImage) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func classifyImage() {
        // Simulate classification (replace with your model)
        DispatchQueue.main.async {
            let categories = ["battery", "biological", "cardboard", "clothes", "glass", "metal", "paper", "plastic", "shoes", "trash"]
            let randomCategory = categories.randomElement() ?? "trash"
            classificationResult = randomCategory
            disposalTechnique = getDisposalTechnique(for: randomCategory)
        }
    }
}


// MARK: - Map View with Search

struct MapViewWithSearch: View {
    @Binding var selectedCategory: String?
    @StateObject private var locationManager = LocationManager()
    @State private var searchText = ""
    @State private var searchResults: [PinnedLocation] = []
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        VStack {
            // Search Bar
            TextField("Search (e.g. clothes donation, metal donation)", text: $searchText, onCommit: search)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Map
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: searchResults) { place in
                MapAnnotation(coordinate: place.coordinate) {
                    VStack {
                        Image(systemName: "mappin")
                            .foregroundColor(.red)
                        Text(place.name)
                            .font(.caption)
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
        }
        .onAppear {
            // Center on user location if available
            if let userLoc = locationManager.userLocation {
                region.center = userLoc
            }
        }
        .onChange(of: selectedCategory) { category in
            if let category = category {
                searchText = "\(category) donation"
                search()
            }
        }
    }
    
    func search() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            searchResults = response.mapItems.map { item in
                PinnedLocation(
                    name: item.name ?? "Unknown",
                    address: item.placemark.title ?? "No address available",
                    coordinate: item.placemark.coordinate,
                    openHours: "Unknown hours",
                    description: "No description available"
                )
            }
        }
    }
}

// MARK: - Home View

struct HomeView: View {
    var body: some View {
        VStack {
            Text("renewIt")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.green)
                .padding(.top, 40)
            Spacer()
            Text("Welcome to renewIt!")
                .font(.title)
            Spacer()
        }
    }
}

// MARK: - Main Content View

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var selectedCategory: String?
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            StartScanningView(selectedTab: $selectedTab, selectedCategory: $selectedCategory)
                .tabItem {
                    Label("Scan", systemImage: "camera")
                }
                .tag(1)
            
            MapViewWithSearch(selectedCategory: $selectedCategory)
                .tabItem {
                    Label("Map", systemImage: "location")
                }
                .tag(2)
        }
    }
}
