const path = require('path');
const webpack = require("webpack");

const CleanWebpackPlugin = require('clean-webpack-plugin');

module.exports = {
  entry: {
    main: [
      './src/main.js'
    ]
  },

  module: {
    rules: [
      { test: /.styl$/, loaders: [ 'raw-loader', 'stylus-loader' ] },
      {
        test: /\.(css|scss)$/,
        use: [
          'style-loader',
          'css-loader',
        ]
      },
      {
        test: /\.elm$/,
        exclude: [ /elm-stuff/, /node_modules/ ],
        loader: 'elm-webpack-loader?verbose=true&warn=true',
      },
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'url-loader?limit=10000&mimetype=application/font-woff',
      },
      {
        test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file-loader',
      },
    ],

    noParse: /\.elm$/,
  },

  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: '[name].bundle.js',
  },

  plugins: [
    new CleanWebpackPlugin([ 'dist/*' ]),
  ],

};