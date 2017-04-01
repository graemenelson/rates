const path = require('path');
const webpack = require('webpack');

module.exports = {
  context: path.resolve(__dirname, './app/client'),
  entry: {
    client: './index.es6',
  },
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, './public/js')
  },
  module: {
    rules: [
      {
        test: /\.es6$/,
        exclude: [/node_modules/],
        use: [{
          loader: 'babel-loader',
          options: { presets: ['es2015'] }
        }],
      },
    ],
  },
};
