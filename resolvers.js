const db = require('./db');
var Isemail = require('isemail');
var req = require('./mail.js');
var jwt = require('jsonwebtoken');
var validationFlag;
var verificationFlag;
var token;
var id;

const Query = {
  test: () => {
    return 'Test Success, GraphQL server is up & running !!'
  },
}

const UserRegistrationResponse = {
  status: (root,args,context,info) => {
    return validationFlag == true? 'SUCCESS' : 'FAIL';
  },
  message: (root,args,context,info) => {
    return root.message;
  },
}

const UserVerifyEmailResponse = {
  status: (root,args,context,info) => {
    return verificationFlag == true? 'SUCCESS' : 'FAIL';
  },
  message: (root,args,context,info) => {
    return root.message;
  },
}

function validateInfo(email, password) {
  
  validationFlag = false;
  
  if (Isemail.validate(email)) {
    
    // Ensure no two users have same email
    const candidate = db.users.list().find((candidate) => candidate.email === email);
    
    if (candidate === undefined) {
      
      // Ensure password is appropriate length 
      if (password.length < 8 ) {
        console.log("Password must be at least 8 characters.");  
      } else {
        validationFlag = true;
      }
    } else {
        // Email name already taken
        console.log("This email is already registered.");
    }
  } else {
      // Email name is not legitimate
      console.log("This email is not valid.");
  }

}

function verifyUser(email, token, secret) {
  
  verificationFlag = false;
  
  // Search for email in database
  const candidate = db.users.list().find((candidate) => candidate.email === email);
  
  // Email name does not exist in db
  if (candidate === undefined) {
    console.log("Invalid email.");
    return;
  }

  // Check for token expiration
  jwt.verify(token, secret.toString('utf8'), function (err, payload) {
    if (err) {
      if (err.name === "TokenExpiredError") {
        console.log("Your token has expired.");
       
      }
    }
  });
   
  // Decoded token
  var decoded = jwt.decode(token, {complete: true});
  
  // Token is not valid
  if (decoded === null) {
    console.log("Invalid token.");
    return;
  }

  // Compare decoded token's id with user id (extracted from email parameter)
  candidate.id === decoded.payload.id? verificationFlag = true : verificationFlag = false;
    
}

function createToken(userId, secret) {

  var token = jwt.sign({ id: userId }, secret.toString('utf8'), { expiresIn: "2m" });
  return token;

}

const Mutation = {
  
  userRegistration: (root,args,{secret},info) => {    
    
    // Validate email and password
    validateInfo(args.email, args.password);
    
    if (validationFlag == true) {

      // Create User in database
      const newMember = db.users.create({email: args.email, password: args.password});
      const newId = db.users.get(newMember);
      
      // Create token for user
      token = createToken(newId.id, secret);
      
      //Send email with token to user
      req.mailIt(args.email, token);
    };

    return { root };

  },

  userVerifyEmail: (root,args,{secret},info) => {
    
    // Verify that email and token correspond    
    verifyUser(args.email, args.token, secret);

    return { root };

  }
}

module.exports = {Query, Mutation, UserRegistrationResponse, UserVerifyEmailResponse}
