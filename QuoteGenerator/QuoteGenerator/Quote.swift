//
//  Quote.swift
//  QuoteGenerator
//
//  Created by Kritika Mehra on 05/09/25.
//

/*
 [
   {
     "q": "If no one ever broke the rules, then we'd never advance.",
     "a": "Simon Sinek",
     "h": "\u003Cblockquote\u003E&ldquo;If no one ever broke the rules, then we'd never advance.&rdquo; &mdash; \u003Cfooter\u003ESimon Sinek\u003C/footer\u003E\u003C/blockquote\u003E"
   }
 ]
 */

import Foundation
struct Quote: Codable, Hashable, Identifiable {
    let id = UUID()
    let text: String
    let author: String
    let html: String

    enum CodingKeys: String, CodingKey {
        case text = "q"
        case author = "a"
        case html = "h"
    }
}
