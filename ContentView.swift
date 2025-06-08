//
//  ContentView.swift
//  renewIt(final)
//
//  Created by Raeva Desai on 6/8/25.
//

import SwiftUI
import CoreLocation
import CoreML
import MapKit

// MARK: - Helper Function

func disposalTechnique(for category: String) -> String {
    switch category {
        case "battery":
            return """
    How to Dispose:
    Batteries, especially rechargeable and lithium-ion types, must be disposed of at certified battery or e-waste recycling centers. Never throw batteries in the regular trash. Many stores such as Best Buy, Staples, and Home Depot provide in-store drop-off bins. Municipal waste services often offer hazardous material collection events for safe disposal.

    Why It Matters:
    Improperly discarded batteries can leak heavy metals like mercury, cadmium, and lead into soil and water supplies, poisoning ecosystems and endangering wildlife. Lithium-ion batteries can even spark fires in landfills and collection trucks, posing a risk to sanitation workers and the public.

    Environmental Benefits:
    Recycling batteries allows for the recovery of valuable resources like cobalt, lithium, and zinc. This reduces the demand for mining, which often leads to deforestation, habitat destruction, and exploitation of vulnerable communities. Choosing to recycle is a powerful step toward a circular, safer electronics economy.
    """

        case "biological":
            return """
    How to Dispose:
    Biological waste, including food scraps, yard trimmings, and biodegradable materials, should be composted. At home, use a compost bin to turn waste into nutrient-rich soil. For those without backyard space, many cities offer green waste collection bins or curbside composting services.

    Why It Matters:
    When food waste ends up in landfills, it decomposes without oxygen and produces methane—a greenhouse gas over 25 times more potent than CO₂. This accelerates climate change and contributes to urban pollution.

    Environmental Benefits:
    Composting transforms waste into organic fertilizer that enriches soil, improves water retention, and reduces the need for chemical fertilizers. It closes the loop in the food cycle and supports healthier agriculture. Choosing compost over trash is a simple but profound act for the planet.
    """

        case "cardboard":
            return """
    How to Dispose:
    Cardboard should be flattened to save space and placed in the paper recycling bin. Be sure to remove all plastic tape, shipping labels, and packaging materials. Wet or greasy cardboard, like pizza boxes, should be composted or placed in the green bin if accepted.

    Why It Matters:
    If contaminated or improperly sorted, cardboard can ruin entire recycling batches, forcing all of it into the landfill. Millions of tons of recyclable cardboard are lost each year due to poor sorting and lack of awareness.

    Environmental Benefits:
    Recycling cardboard saves trees, reduces water usage, and cuts down on air pollution from incineration or decomposition in landfills. Every ton recycled saves 46 gallons of oil and 700 gallons of water. Your pizza box might seem small—but together, these choices shape a greener future.
    """

        case "clothes":
            return """
    How to Dispose:
    If your clothes are in wearable condition, donate them to thrift stores, shelters, or textile donation bins. Unwearable or torn clothes should be dropped off at textile recycling programs—check with local waste facilities or large retailers like H&M and Levi’s, which often run take-back programs.

    Why It Matters:
    The fashion industry is the second-largest consumer of water and one of the biggest polluters. Americans throw away over 11 million tons of textiles annually, and most end up in landfills, where synthetic fabrics can take over 200 years to break down—leaching dyes and microplastics into the environment.

    Environmental Benefits:
    Reusing and recycling clothes reduces the demand for fast fashion, cuts back on water and chemical usage, and prevents pollution. Donating or recycling just one bag of clothes extends their life and lightens the environmental burden of overproduction.
    """

        case "glass":
            return """
    How to Dispose:
    Rinse glass containers clean and place them in the designated glass recycling bin. Avoid placing broken glass in curbside bins unless instructed, as it may pose a hazard to sanitation workers. Instead, wrap sharp edges securely and drop it off at a recycling center that accepts it.

    Why It Matters:
    Glass that’s contaminated with food or non-recyclables can break down the efficiency of recycling plants. When not recycled, glass takes over 4,000 years to decompose in landfills.

    Environmental Benefits:
    Glass is 100% recyclable and can be recycled endlessly without losing purity or quality. Recycling just one glass bottle saves enough energy to power a 100-watt light bulb for 4 hours. It's one of the most efficient ways to reduce energy consumption and pollution.
    """

        case "metal":
            return """
    How to Dispose:
    Rinse metal cans, lids, and containers and place them in your recycling bin. For larger metal objects—appliances, wires, tools—take them to a scrap metal recycling yard or a donation center if they still work. Many cities also offer bulk item collection events.

    Why It Matters:
    Throwing away metal wastes vast amounts of energy. Mining for new metal ores destroys landscapes, generates toxic runoff, and emits significant CO₂.

    Environmental Benefits:
    Recycling aluminum saves 95% of the energy used to make it from raw materials. Steel, copper, and tin are also infinitely recyclable. Choosing to recycle metal helps preserve finite resources and dramatically reduces greenhouse gas emissions.
    """

        case "paper":
            return """
    How to Dispose:
    Place clean, dry paper in your recycling bin. Newspapers, office paper, magazines, and books without plastic covers are all recyclable. Avoid recycling food-soiled or wax-coated paper. Shredded paper should be bagged and taken to specialized collection centers.

    Why It Matters:
    Contaminated paper can damage recycling machines and spoil entire batches of recyclables. When landfilled, paper contributes to methane emissions as it decomposes.

    Environmental Benefits:
    Recycling one ton of paper saves 17 trees, 7,000 gallons of water, and enough energy to power the average home for six months. Paper can be recycled 5–7 times before the fibers become too short to reuse, making it a valuable resource worth recovering.
    """

        case "plastic":
            return """
    How to Dispose:
    Check the number inside the recycling triangle on the plastic item. Types #1 and #2 (like soda bottles and milk jugs) are widely accepted. Rinse all plastics before recycling. For plastic bags, films, and foam, take them to designated drop-off points—never put them in curbside bins.

    Why It Matters:
    Plastic doesn't biodegrade—it photodegrades, breaking into microplastics that pollute oceans, harm wildlife, and even enter human bodies through food and water.

    Environmental Benefits:
    Recycling plastic reduces the need for petroleum extraction, conserves energy, and keeps plastics out of oceans and landfills. Every recycled bottle matters—it’s one less choking hazard for marine animals and one more step toward a cleaner planet.
    """

        case "shoes":
            return """
    How to Dispose:
    If shoes are in usable condition, donate them to shelters, thrift stores, or charities. For worn-out shoes, look for specialized textile or shoe recycling programs—some retailers like Nike offer take-back bins where shoes are turned into playground materials or new products.

    Why It Matters:
    Shoes contain rubber, foam, leather, and synthetic materials—most of which are not biodegradable. Tossed into landfills, they take centuries to decompose and release toxic chemicals as they break down.

    Environmental Benefits:
    Recycling shoes reduces landfill pressure and provides materials for reuse in new products. Donating shoes gives them a second life—often helping someone in need. Your old sneakers could be turned into a running track or playground surface for kids.
    """

        case "trash":
            return """
    How to Dispose:
    For items that can’t be recycled or composted, dispose of them in the trash bin. These often include dirty food wrappers, waxed paper, foam takeout containers, and other mixed materials. Always double-check with your local waste authority before assuming something belongs in the trash.

    Why It Matters:
    Landfilling mixed waste consumes space, produces methane, and leaches chemicals into soil and groundwater. Once buried, most trash remains for hundreds of years, taking a permanent toll on the environment.

    Environmental Tip:
    Before tossing something, ask: Can it be reused? Can it be repaired? Is there a specialized recycling program for this? Mindful disposal helps reduce the overall volume of waste and keeps materials in circulation longer.
    """

        default:
            return """
    How to Dispose:
    If you’re unsure how to dispose of an item, start by checking your city’s waste management website or app. Many municipalities provide searchable databases that explain how to recycle or dispose of specific items, from electronics to light bulbs to medications.

    Why It Matters:
    Improper disposal can harm people, animals, and the planet. Many items—especially electronics, chemicals, and textiles—require special handling. Guessing leads to contamination and more waste sent to landfills.

    Environmental Benefits:
    Becoming informed empowers you to make choices that protect natural resources and reduce environmental harm. When in doubt, ask questions, look it up, and take that extra step. Each responsible decision sends a message: that your community cares about the planet.
    """
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

// MARK: - StartScanningView

struct StartScanningView: View {
    @Binding var selectedTab: Int
    @Binding var selectedCategory: String?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var classificationResult: String?
    @State private var disposalInstruction: String?

    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                if let image = inputImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 280)
                        .padding(.horizontal, 24)
                        .padding(.top, 40)
                        .shadow(radius: 8)
                }

                if let result = classificationResult {
                    VStack(spacing: 12) {
                        Text("Detected: \(result.capitalized)")
                            .font(.system(.title2, design: .rounded).weight(.semibold))
                            .foregroundColor(.green)
                            .padding(.top, inputImage == nil ? 0 : 16)

                        if let technique = disposalInstruction {
                            ScrollView {
                                Text(technique)
                                    .font(.system(.body, design: .rounded))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal, 24)
                            }
                            .frame(maxHeight: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Spacer()
                    Text("Take a picture to scan!")
                        .font(.system(.title2, design: .rounded).weight(.semibold))
                        .foregroundColor(.gray)
                        .padding(.bottom, 16)
                    Spacer()
                }
            }

            VStack {
                Spacer()
                Button(action: {
                    showingImagePicker = true
                }) {
                    Text("Start Scanning")
                        .font(.system(.title3, design: .rounded).weight(.semibold))
                        .foregroundColor(.white)
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(14)
                        .shadow(radius: 4)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: classifyImage) {
            ImagePicker(image: $inputImage)
        }
    }

    func classifyImage() {
        guard let image = inputImage,
              let buffer = image.pixelBuffer(width: 224, height: 224) else {
            print("Image processing failed.")
            return
        }
        do {
            let model = try wasteClassification(configuration: MLModelConfiguration())
            let prediction = try model.prediction(image: buffer)
            let category = prediction.target

            classificationResult = category
            disposalInstruction = disposalTechnique(for: category)
        } catch {
            print("Classification error: \(error)")
            classificationResult = "Unknown"
            disposalInstruction = disposalTechnique(for: "Unknown")
        }
    }
}




// MARK: - HomeView

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to Renew It!")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.green)
                .padding(.top, 40)
            ArticleListView(articles: articles)
                .padding(.horizontal)
        }
    }
}

// MARK: - ContentView

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

// MARK: - UIImage Extension

extension UIImage {
    func pixelBuffer(width: Int, height: Int) -> CVPixelBuffer? {
        let attrs = [
            kCVPixelBufferCGImageCompatibilityKey: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey: true
        ] as CFDictionary
        var pixelBuffer: CVPixelBuffer?

        let status = CVPixelBufferCreate(
            kCFAllocatorDefault,
            width,
            height,
            kCVPixelFormatType_32ARGB,
            attrs,
            &pixelBuffer
        )

        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
            return nil
        }

        CVPixelBufferLockBaseAddress(buffer, [])
        defer { CVPixelBufferUnlockBaseAddress(buffer, []) }

        guard let context = CGContext(
            data: CVPixelBufferGetBaseAddress(buffer),
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
        ) else {
            return nil
        }

        UIGraphicsPushContext(context)
        draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        UIGraphicsPopContext()

        return buffer
    }
}
