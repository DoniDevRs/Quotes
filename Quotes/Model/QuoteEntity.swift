//
//  QuoteEntity.swift
//  QuotesApp
//
//  Created by Doni Silva on 24/08/24.
//

import Foundation

public struct QuoteEntity {
    public let quote: String
    public let author: String
    public let image: String
    
    public var formattedQuote: String {
        return " ‟" + quote + "”"
    }
    
    public var formattedAuthor: String {
        return "- " + author + " -"
    }
}
