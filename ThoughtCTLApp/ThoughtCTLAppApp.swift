//
//  ThoughtCTLAppApp.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 13/12/23.
//

import SwiftUI

@main
struct ThoughtCTLAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                GalleryView()
            }
        }
    }
}
