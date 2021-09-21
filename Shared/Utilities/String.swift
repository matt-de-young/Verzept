//
//  String.swift
//  Forking
//
//  Created by Matt de Young on 21.09.21.
//

import Foundation

extension String
{
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    var lines: [SubSequence] { split(whereSeparator: \.isNewline) }
}
