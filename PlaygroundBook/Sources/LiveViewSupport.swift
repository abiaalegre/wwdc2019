//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import PlaygroundSupport

/// Instantiates a new instance of a live view.
///
/// By default, this loads an instance of `LiveViewController` from `LiveView.storyboard`.
public func instantiateLiveView(pageIdentifier: (Int,Int)) -> PlaygroundLiveViewable {
    
    var liveViewControler = PlaygroundPage.current.liveView
    
    switch pageIdentifier {
    case (1,1):
        print("view controller 1")
        liveViewControler = C1P1()
    case (1,2):
        print("view controller 2")
        liveViewControler = C1P2()
    default:
        fatalError("A valid ViewController on LiveView.storyboard could not be found.")
    }

    return liveViewControler!
}

