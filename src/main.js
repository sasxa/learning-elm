'use strict';

import { Main } from './app/Main.elm';

// const Elm = require('./app/Main.elm');
const root = document.querySelector('app-root');
const flags = "this should be an object";

// .embed() can take an optional second argument. 
// This would be an object describing the data we need to start a program, 
// i.e. a userID or some token

const app = Main.embed(root, flags);
// const app = Elm.Main.embed(root, flags);
