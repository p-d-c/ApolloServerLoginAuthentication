import SwiftUI

struct VerificationFailureView: View {
    
    @State var failedTag : Int? = nil;
    
    var body: some View {
        VStack{
            
            Text(verificationError)
                .foregroundColor(.red)
            
            Spacer()
                .frame(height: 20)
            
            Button(action: {
                // Return to verification view
                self.failedTag = 4;
            }) {
                    Text("Retry")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .font(.title)
            }
            
            NavigationLink(destination: VerifyEmailView(), tag: 4, selection: $failedTag) {
                    EmptyView()
            }
        }
        .padding(0.1)
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

struct VerificationFailureView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationFailureView()
    }
}
