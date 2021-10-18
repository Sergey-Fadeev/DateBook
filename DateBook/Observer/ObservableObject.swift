//
//  ObservableObject.swift
//  DateBook
//
//  Created by Sergey on 18.10.2021.
//

import Foundation

protocol ObservableObject: AnyObject {
    var objectWillChange: PublisherProtocol{get}
}
