//
//  ArticleList.swift
//  renewIt(final)
//
//  Created by Raeva Desai on 6/8/25.
//

import Foundation
import SwiftUI

struct ArticleListView: View {
    let articles: [Article]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(articles) { article in
                    ArticleCard(article: article)
                }
            }
            .padding()
        }
    }
}

import SwiftUI

struct ArticleCard: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Image preview (local asset)
            Image(article.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .clipped()
                .cornerRadius(8)
            
            // Text content
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(article.summary)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding([.horizontal, .bottom])
        }
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .onTapGesture {
            UIApplication.shared.open(article.url)
        }
    }
}

struct ArticleDetailView: View {
    let article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(article.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(article.summary)
                    .font(.title3)
                    .foregroundColor(.secondary)
                Divider()
                Text(article.content)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(article.title)
    }
}
