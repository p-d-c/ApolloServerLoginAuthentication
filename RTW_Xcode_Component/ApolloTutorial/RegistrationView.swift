import SwiftUI
import Apollo

var registrationError = "Email and/or password is invalid. Please try again."

struct RegistrationView: View {
    
    @State var email = ""
    @State var password = ""
    @State var registrationErrorMessage = ""
    @ObservedObject var user = RegistrationViewModel()
    @State var registeredTag : Int? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField(" Enter email.", text: $email)
                    .border(Color.black)
                
                TextField(" Enter password.", text: $password)
                    .border(Color.black)
                
                Button(action: {
                    self.user.email = self.email;
                    self.user.password = self.password;
                    Network.shared.apollo.perform(mutation:RegisterUserMutation(email: self.user.email, password: self.user.password))
                    {result
                        in
                        guard let data = try? result.get().data else { return }
                        if (data.userRegistration.status == ResponseStatus.success) {
                            // Go to success view
                            self.registrationErrorMessage = "";
                            self.registeredTag = 1;
                        } else {
                            // Prompt user with error message
                            self.registrationErrorMessage = registrationError;
                            // Stay in this view
                            self.registeredTag = 0;
                        }
                    }
                }) {
                    Text("Register")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                NavigationLink(destination: VerifyEmailView(), tag: 1, selection: $registeredTag) {
                    EmptyView()
                }
                
                Text(self.registrationErrorMessage)
                    .foregroundColor(.red)
            }
            .padding(0.1)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

