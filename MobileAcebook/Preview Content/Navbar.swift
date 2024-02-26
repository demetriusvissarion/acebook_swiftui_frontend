//
//  Navbar.swift
//  MobileAcebook
//
//  Created by Aisha Mohamed on 21/02/2024.
//

import Foundation

import SwiftUI

struct Navbar: View {
    @State private var shouldNavigate = false
    var body: some View {
        NavigationView{
        VStack{
            HStack{
                Image("logo-acebook")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
//                    .padding()
                Spacer()
                NavigationLink(
                    destination: ProfileView(),
                    label: {
                        Text("Profile")
                            .foregroundColor(.black)
                            
                    }
                )
                NavigationLink(
                    destination: FeedView(),
                    label: {
                        Text("Feed")
                            .foregroundColor(.black)
                            
                    }
                )
            }
            
            Spacer()
        }
    }
    }
}

struct NavbarView_Previews: PreviewProvider {
    static var previews: some View {
        Navbar()
    }
}
