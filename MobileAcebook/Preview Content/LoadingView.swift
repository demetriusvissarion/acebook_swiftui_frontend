

import SwiftUI
import Foundation
struct LoadingView: View {
    var body: some View {

        Spacer()
        
        Image("a-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .padding()
        
        Spacer()
        
        Text("from")
            .foregroundColor(Color.gray)
        
        Image("makers-logo")
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            .foregroundColor(Color(UIColor(rgb: 0x1877F2)))
        
    }
}
