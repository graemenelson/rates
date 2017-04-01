const path = require('path');
const webpack = require('webpack');

module.exports = {
  context: path.resolve(__dirname, './app/client'),
  entry: {
    client: './index.js',
  },
  output: {
    filename: '[name].bundle.js',
    path: path.resolve(__dirname, './public/js')
  },
  resolve: {
    extensions: ['.js', '.json', '.scss'],
    modules: [path.resolve('./'), 'node_modules'],
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: [/node_modules/],
        use: [{
          loader: 'babel-loader',
          options: { presets: ['es2015', 'react'] }
        }],
      },
      {
        test: /\.(sass|scss)$/,
        use: [
          'style-loader',
          'css-loader',
          'sass-loader',
        ]
      },
    ],
  },
};
