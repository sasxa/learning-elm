const path = require('path');
const merge = require('webpack-merge');
const common = require('./webpack.config.js');

const HtmlWebpackPlugin = require('html-webpack-plugin');
const webpack = require("webpack");

module.exports = merge(common, {

  module: {
    rules: [
      {
        test: /\.elm$/,
        exclude: [ /elm-stuff/, /node_modules/ ],
        use: [
          'elm-hot-loader',
          'elm-webpack-loader?verbose=true&warn=true'
        ],
      },
    ]
  },

  devServer: {
    inline: true,
    stats: { colors: true },
    hot: true,
  },

  plugins: [
    new webpack.NamedModulesPlugin(),
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
      inject: true,
      template: 'src/index.html'
    })
  ]
});