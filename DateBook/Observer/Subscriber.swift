//
//  Subscriber.swift
//  DateBook
//
//  Created by Sergey on 18.10.2021.
//

import Foundation


class EscapingSubscriber: Observer {
    var closure:()->Void
    
    
    func update() {
        closure()
    }
    
    
    init(closure:@escaping ()->Void){
        self.closure = closure
    }
}
