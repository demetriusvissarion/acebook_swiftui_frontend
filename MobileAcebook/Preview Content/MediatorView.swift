

import Foundation
import SwiftUI

struct MediatorView: View {
    @State private var isLoadingActive: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                LoadingView()
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                            self.isLoadingActive = true
                        }
                    }
                NavigationLink(destination: LoginPage(authenticationService: AuthenticationService()), isActive: $isLoadingActive) {
                    EmptyView()
                }
                .hidden()
            }
        }
    }
}

struct MediatorViewPage_Previews: PreviewProvider {
    static var previews: some View {
        MediatorView()
    }
}
