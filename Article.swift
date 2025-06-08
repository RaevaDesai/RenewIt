import SwiftUI

struct Article: Identifiable {
    let id: Int
    let title: String
    let summary: String
    let content: String
    let imageName: String // For local images, or use imageURL for remote images
    let url: URL
}

let articles = [
    Article(
        id: 1,
        title: "Thrifting Tips for Beginners",
        summary: "Learn how to thrift effectively and sustainably.",
        content: "Thrifting is a great way to save money and reduce waste. Start by exploring local thrift stores and online marketplaces...",
        imageName: "thrifting", // Use your asset name
        url: URL(string: "https://www.goodhousekeeping.com/life/money/a30769198/how-to-thrift-shop/")!
    ),
    Article(
        id: 2,
        title: "How to Donate Clothes Responsibly",
        summary: "Best practices for donating clothes to charities.",
        content: "Donating clothes can help those in need and reduce landfill waste. Make sure your clothes are clean and in good condition...",
        imageName: "donate", // Use your asset name
        url: URL(string: "https://www.goodwill.org/donate/ways-to-give/donate-stuff/")!
    ),
    Article(
        id: 3,
        title: "Recycling 101: What You Need to Know",
        summary: "A beginner's guide to recycling correctly.",
        content: "Recycling helps conserve resources and reduce pollution. Learn what materials can be recycled and how to prepare them...",
        imageName: "recycling", // Use your asset name
        url: URL(string: "https://www.epa.gov/recycle/recycling-basics")!
    ),
    Article(
        id: 4,
        title: "Environmental Safety at Home",
        summary: "Tips to keep your home environmentally safe.",
        content: "Reduce your carbon footprint by using energy-efficient appliances, reducing water waste, and choosing eco-friendly products...",
        imageName: "environment", // Use your asset name
        url: URL(string: "https://www.epa.gov/environmental-topics/green-living")!
    ),
    Article(
        id: 5,
        title: "The Benefits of Upcycling",
        summary: "Creative ways to upcycle old items.",
        content: "Upcycling transforms old or discarded items into something useful or beautiful, reducing waste and saving money...",
        imageName: "upcycling", // Use your asset name
        url: URL(string: "https://www.goodhousekeeping.com/home/craft-ideas/g2545/upcycling-ideas/")!
    )
]
