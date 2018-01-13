const path = require('path');
const merge = require('webpack-merge');
const common = require('./webpack.config.js');

const UglifyJSPlugin = require('uglifyjs-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const webpack = require("webpack");

module.exports = merge(common, {

  output: {
    filename: '[name].[hash].bundle.js',
  },

  plugins: [
    new UglifyJSPlugin(),
    new webpack.HashedModuleIdsPlugin(),
    new HtmlWebpackPlugin({
      inject: true,
      minify: {
        collapseWhitespace: true,
        minifyCSS: true,
        removeComments: true,
      },
      template: 'src/index.html'
    })
  ]
});