//
//  Book.swift
//  BookAppAnimation
//
//  Created by Seungchul Ha on 2022/12/16.
//

import Foundation
import SwiftUI

// MARK: Book Model And Sample Data
struct Book: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var imageName: String
    var author: String
}

var sampleBooks: [Book] = [
    .init(title: "Harry Potter And The Order of The Phoenix", imageName: "Book1", author: "J.K. Rowling"),
    .init(title: "The Old Man and The Sea", imageName: "Book2", author: "Ernest Hemingway"),
    .init(title: "One Up On Wall Street", imageName: "Book3", author: "Peter Lynch"),
    .init(title: "TomTurbo", imageName: "Book4", author: "Thomas Brezina"),
    .init(title: "Sherlock Holmes: However Improbable", imageName: "Book5", author: "David Marcum")
]
