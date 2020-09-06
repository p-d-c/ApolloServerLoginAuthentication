import SwiftUI
import Apollo

var verificationError = "Email and/or token is invalid. Please try again."

struct VerifyEmailView: View {
    
    @State var email = ""
    @State var token = ""
    @State var verificationErrorMessage = ""
    @ObservedObject var user = VerifyEmailViewModel()
    @State var verifiedTag : Int? = nil

    var body: some View {
        VStack {
            
            TextField(" Enter email.", text: $email)
                .border(Color.black)
            
            TextField(" Enter token.", text: $token)
                .border(Color.black)
            
            Button(action: {
                self.user.email = self.email;
                self.user.token = self.token;
                Network.shared.apollo.perform(mutation:VerifyUserMutation(email: self.user.email, token: self.user.token))
                {result
                    in
                    guard let data = try? result.get().data else { return }
                    if (data.userVerifyEmail.status == ResponseStatus.success) {
                        // Go to success view
                        self.verificationErrorMessage = "";
                        self.verifiedTag = 2;
                    } else {
                        // Prompt user with error message
                        self.verificationErrorMessage = verificationError;
                        // Go to failure view
                        self.verifiedTag = 3;
                    }
                }
            }) {
                Text("Verify")
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .font(.title)
            }
            
            NavigationLink(destination: VerificationSuccessView(), tag: 2, selection: $verifiedTag) {
                EmptyView()
            }
            
            NavigationLink(destination: VerificationFailureView(), tag: 3, selection: $verifiedTag) {
                EmptyView()
            }
        }
        .padding(0.1)
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
    }
}
    
struct VerifyEmailView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyEmailView()
    }
}

