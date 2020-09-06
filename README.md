# ApolloServerRegistrationAuthentication

Last updated: January 2020

Languages: Swift (Client), SwiftUI (Client), Node.js (Server), GraphQL (Server)
Software: Apollo (Server Platform), GraphQL

![ApolloGraphQLRegistrationVerification](https://user-images.githubusercontent.com/34993622/92330960-ceac2380-f027-11ea-992d-5e8009e4aedc.gif)

Summary: This two-part (server and client) project sets up an Apollo GraphQL server that allows users to register and verify their account through token authentication.


This is my iOS Swift/SwiftUI coding challenge, which involved Apollo and GraphQL.
There are two components to the project: the server and the Xcode application.
RTW_Xcode_Component is the application, and RTW_Server_Component is the
corresponding server.

Notes:
Server:

The secret for the jsonwebtoken is stored in .env (see: vi .env). This
requires the 'dotenv' library, which must be installed (command: npm install
dotenv).
To run the server:
1) Go to iOSCodeChallenge_Priya >
RTW_Apollo_Project >
RTW_Server_Component
2) Type "node index.js"
3) Go to the server URL
The URL of the server is http://localhost:4000/graphql.dev.rtw.team

The database library used is 'notarealdb'.
The Express library is used for its app capabilities.
Pepipost is the name of the service/API used to send emails to users.
The jsonwebtoken is set to expire after 2 minutes.

Xcode Project:

There are four main views: RegistrationView, VerifyEmailView,
VerificationSuccessView, and VerificationFailureView. Users can
register (with a valid email and password), receive a token,
and verify that token (with a valid email and token).
The apollo client is inititated in 'Network.swift'.





