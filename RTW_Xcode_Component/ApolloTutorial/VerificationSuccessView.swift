import SwiftUI

struct VerificationSuccessView: View {
    var body: some View {
        VStack{
            
            Text("Token successfully verified.")
                .foregroundColor(.green)
            
            Spacer()
                .frame(height: 20)
            
            // Photo by Plush Design Studio on Unsplash
            Image("Gift")
                .resizable()
                .frame(width: 200.0, height: 200.0)
        }
        .padding(0.1)
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

struct VerificationSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationSuccessView()
    }
}
