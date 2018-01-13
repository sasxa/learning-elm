'use strict';

const Elm = require('./app/Main.elm');
const root = document.querySelector('app-root');

// .embed() can take an optional second argument. 
// This would be an object describing the data we need to start a program, 
// i.e. a userID or some token
const app = Elm.Main.embed(root);