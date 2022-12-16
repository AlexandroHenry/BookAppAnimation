//
//  Home.swift
//  BookAppAnimation
//
//  Created by Seungchul Ha on 2022/12/16.
//

import SwiftUI

struct Home: View {
    
    // MARK: Animation Properties
    @State var currentBook: Book = sampleBooks.first!
    
    var body: some View {
        VStack {
            HeaderView()
            
            BookSlider()
            
            // MARK : Detail's View
            BookDetailView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    func BookDetailView() -> some View {
        VStack {
            GeometryReader {
                let size = $0.size
                
                // MARK: Implementing Delayed Effect
                HStack(spacing: 0) {
                    ForEach(sampleBooks) { book in
                        
                        let index = indexOf(book: book)
                        let currentIndex = indexOf(book: currentBook)
                        
                        VStack(alignment: .leading, spacing: 18) {
                            Text(book.title)
                                .font(.largeTitle)
                                .foregroundColor(.black.opacity(0.7))
                                // MARK: Sliding to the Current Index Position with Delay Based on Index
                                .offset(x: CGFloat(currentIndex) * -(size.width + 30))
                                .opacity(currentIndex == index ? 1 : 0)
                                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(currentIndex < index ? 0.1 : 0), value: currentIndex == index)
                            
                            Text("By \(book.author)")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .offset(x: CGFloat(currentIndex) * -(size.width + 30))
                                .opacity(currentIndex == index ? 1 : 0)
                                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(currentIndex > index ? 0.1 : 0), value: currentIndex == index)
                        }
                        .frame(width: size.width + 30, alignment: .leading)
                    }
                }
            }
            .padding(.horizontal, 15)
            .frame(height: 100)
            .padding(.bottom, 10)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.gray.opacity(0.4))
                
                GeometryReader {
                    let size = $0.size
                    
                    // MARK: Updating Progress When Ever Current Book is Updated
                    Capsule()
                        .fill(Color("Green"))
                        .frame(width: CGFloat(indexOf(book: currentBook)) / CGFloat(sampleBooks.count - 1) * size.width)
                        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.75, blendDuration: 0.75), value: currentBook)
                }
            }
            .frame(height: 4)
            .padding(.top, 10)
            .padding([.horizontal, .bottom], 15)
        }
    }
    
    // MARK: Index
    func indexOf(book: Book) -> Int {
        if let index = sampleBooks.firstIndex(of: book) {
            return index
        }
        
        return 0
    }
    
    // MARK: Book Slider
    @ViewBuilder
    func BookSlider() -> some View {
        TabView(selection: $currentBook) {
            ForEach(sampleBooks) { book in
                BookView(book: book)
                    .tag(book)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .background {
            Image("BG")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
    
    // MARK: Book View
    @ViewBuilder
    func BookView(book: Book) -> some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                
                // MARK: Book Like View
                // With the Help of Isometric View
                // Refer this Link : https://youtu.be/PVCMAo4gtFM
                IsometricView(depth: 10) {
                    Color.white
                } bottom: {
                    Color.white
                } side: {
                    Color.white
                }
                .frame(width: size.width / 1.2, height: size.height / 1.5)

                
                Image(book.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width / 1.2, height: size.height / 1.5)
                    .clipped()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.horizontal, 50)
    }
    
    // MARK: Header View
    @ViewBuilder
    func HeaderView() -> some View {
        HStack(spacing: 15) {
            Text("Bookio")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.7))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                
            } label: {
                Image(systemName: "books.vertical")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            
            Button {
                
            } label: {
                Image(systemName: "book.closed")
                    .font(.title3)
                    .foregroundColor(.gray)
            }
        }
        .padding(15)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
