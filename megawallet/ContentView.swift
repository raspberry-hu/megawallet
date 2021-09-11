//
//  ContentView.swift
//  megawallet
//
//  Created by hu on 2021/9/11.
//

import SwiftUI

struct ContentView: View {

      var body: some View {

        AppTabNavigation()

    }

}

enum Tab {
    case file_function

    case photo_function
    
    case mega_function
    
    case chat_function
    
    case share_function

}

struct AppTabNavigation: View {

    @State var selection: Tab = .mega_function

    @State var showSheet = false

    var body: some View {

        TabView(selection: $selection) {

            NavigationView {
                filewallet()
            }.navigationBarHidden(true)

            .navigationBarBackButtonHidden(true)

            .navigationViewStyle(StackNavigationViewStyle())

            .tabItem {
                Image(selection == Tab.file_function ? "cloudDriveIcon_red" : "cloudDriveIcon")
            }

            .tag(Tab.file_function)

            NavigationView {
                Text("2")
            }.navigationBarHidden(true)

            .navigationBarBackButtonHidden(true)

            .navigationViewStyle(StackNavigationViewStyle())

            .tabItem {
                Image(selection == Tab.photo_function ? "cameraUploadsIcon_red" : "cameraUploadsIcon")
                    .accessibility(label: Text("Photo"))
            }
            .tag(Tab.photo_function)
            
            NavigationView {

                Image("mega_photo")
                    .resizable()
                    .frame(width: 430.0, height: 900.0)
            }.navigationBarHidden(true)

            .navigationBarBackButtonHidden(true)

            .navigationViewStyle(StackNavigationViewStyle())

            .tabItem {
                Image(selection == Tab.mega_function ? "home_red" : "home")
                    .accessibility(label: Text("Mega"))
            }
            .tag(Tab.mega_function)
            
            NavigationView {

                Text("4")

            }.navigationBarHidden(true)

            .navigationBarBackButtonHidden(true)

            .navigationViewStyle(StackNavigationViewStyle())

            .tabItem {

                Image(selection == Tab.chat_function ? "chatIcon_red" : "chatIcon")

                    .accessibility(label: Text("Chat"))

            }

            .tag(Tab.chat_function)
            
            NavigationView {

                Text("5")

            }.navigationBarHidden(true)

            .navigationBarBackButtonHidden(true)

            .navigationViewStyle(StackNavigationViewStyle())

            .tabItem {
                Image(selection == Tab.share_function ? "sharedItemsIcon_red" : "sharedItemsIcon")
                    .accessibility(label: Text("Share"))

            }

            .tag(Tab.share_function)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
