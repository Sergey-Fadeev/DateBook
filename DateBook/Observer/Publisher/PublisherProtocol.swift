//
//  PublisherProtocol.swift
//  DateBook
//
//  Created by Sergey on 18.10.2021.
//

import Foundation


protocol PublisherProtocol: AnyObject {
    func sink(update:@escaping() -> Void) -> Cancellable
    func subscribe(_ observer: Observer)
    func unsubscribe(_ observer: Observer)
    func notify()
}



protocol Observer: AnyObject{
    func update()
}
