const { GraphQLServer, PubSub } = require('graphql-yoga')
const bodyParser = require('body-parser')
const express = require('express');
const cors = require('cors');
const db = require('./db');
const env = require('dotenv').config();

const {
  graphql,
  GraphQLSchema,
  GraphQLObjectType,
  GraphQLString,
  GraphQLEnumType
} = require('graphql');
const { ApolloServer, gql } = require('apollo-server-express');

const PORT = 4000;
const app = express();
const endPoint = '/graphql.dev.rtw.team';

const fs = require('fs')
const typeDefs = fs.readFileSync('./schema.graphql',{encoding:'utf-8'})
const resolvers = require('./resolvers')

app.use(cors(), bodyParser.json());

const server = new ApolloServer({ 
  typeDefs, 
  resolvers,
  context: ({
    secret: process.env.SECRET,
  }),
});

server.applyMiddleware({
    app,
    path: endPoint,
    cors: true,
  });

app.listen({ port: PORT }, () =>
  console.log(`🚀 Server ready at http://localhost:4000${server.graphqlPath}`)
)
