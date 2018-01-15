const path = require('path');
const webpack = require("webpack");
const merge = require('webpack-merge');

const CleanWebpackPlugin = require('clean-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const UglifyJSPlugin = require('uglifyjs-webpack-plugin');

const DEVELOPMENT = process.env.npm_lifecycle_event !== 'build';

const commonConfig = {
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

const devConfig = {
  module: {
    rules: [
      {
        test: /\.elm$/,
        exclude: [ /elm-stuff/, /node_modules/ ],
        use: [
          'elm-hot-loader',
          {
            loader: 'elm-webpack-loader',
            options: {
              verbose: true,
              warn: true,
              debug: true
            }
          }
        ],
      },
    ]
  },

  devServer: {
    inline: true,
    stats: { colors: true },
    hot: true,
    historyApiFallback: true,
    port: 3000,
    quiet: true,
  },

  plugins: [
    new webpack.NamedModulesPlugin(),
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
      inject: true,
      template: 'src/index.html'
    })
  ]
};

const prodConfig = {
  module: {
    rules: [
      {
        test: /\.elm$/,
        exclude: [ /elm-stuff/, /node_modules/ ],
        use: [
          {
            loader: 'elm-webpack-loader',
            options: {
              verbose: true,
              warn: true,
            }
          }
        ],
      },
    ]
  },

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
};

module.exports
  = merge(commonConfig,
    DEVELOPMENT
      ? devConfig
      : prodConfig);