//
//  IsometricView.swift
//  BookAppAnimation
//
//  Created by Seungchul Ha on 2022/12/16.
//

import SwiftUI

// MARK: Animatable Projection Transform
struct CustomProjection: GeometryEffect {
    var b: CGFloat
    var c: CGFloat
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        
        get {
            return AnimatableData(b,c)
        }
        
        set {
            b = newValue.first
            c = newValue.second
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        return .init(.init(a: 1, b: b, c: c, d: 1, tx: 0, ty: 0))
    }
}

// MARK: Custom View
struct IsometricView<Content: View, Bottom: View, Side: View>: View {
    var content: Content
    var bottom: Bottom
    var side: Side
    
    // MARK: Isometric Depth
    var depth: CGFloat
    
    init(depth: CGFloat, @ViewBuilder content: @escaping() -> Content, @ViewBuilder bottom: @escaping() -> Bottom, @ViewBuilder side: @escaping() -> Side) {
        self.depth = depth
        self.content = content()
        self.bottom = bottom()
        self.side = side()
    }
    
    var body: some View {
        Color.clear
        // For Geometry To Take The Specified Space
            .overlay {
                GeometryReader {
                    let size = $0.size
                    
                    ZStack {
                        content
                        DepthView(isBottom: true, size: size)
                        DepthView(size: size)
                    }
                    .frame(width: size.width, height: size.height)
                }
            }
    }
    
    // MARK: Depth View's
    @ViewBuilder
    func DepthView(isBottom: Bool = false, size: CGSize) -> some View {
        ZStack {
            // MARK: If You Don't want Original Image But Needed a Stretch at the Side & Bottom User This Method
            if isBottom {
                bottom
                    .scaleEffect(y: depth, anchor: .bottom)
                    .frame(height: depth, alignment: .bottom)
                    // MARK: Dimming Content With Blur
                    .overlay(content: {
                        Rectangle()
                            .fill(.black.opacity(0.25))
                            .blur(radius: 2.5)
                    })
                    .clipped()
                    // MARK: Applying Transfroms
                    // MARK: Your Custom Projection Values
                    .projectionEffect(.init(.init(a: 1, b: 0, c: 1, d: 1, tx: 0, ty: 0)))
                    .offset(y: depth)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            } else {
                side
                    .scaleEffect(x: depth, anchor: .trailing)
                    .frame(width: depth, alignment: .trailing)
                    .overlay(content: {
                        Rectangle()
                            .fill(.black.opacity(0.25))
                            .blur(radius: 2.5)
                    })
                    .clipped()
                    // MARK: Applying Transforms
                    // MARK: Your Custom Projection Values
                    .projectionEffect(.init(.init(a: 1, b: 1, c: 0, d: 1, tx: 0, ty: 0)))
                    // MARK: Change Offset, Transform Values for your Wish
                    .offset(x: depth)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
    
    
   
}
