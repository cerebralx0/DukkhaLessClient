'use strict'

const path = require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const webpack = require('webpack')
const CopyPlugin = require('copy-webpack-plugin')
const isWebpackDevServer = process.argv.some(
  a => path.basename(a) === 'webpack-dev-server'
)

const isWatch = process.argv.some(a => a === '--watch')

const plugins =
  isWebpackDevServer || !isWatch
    ? []
    : [
        function() {
          this.plugin('done', function(stats) {
            process.stderr.write(stats.toString('errors-only'))
          })
        }
      ]

const mode = process.env.NODE_ENV || 'development'

module.exports = {
  devtool: 'eval-source-map',

  devServer: {
    contentBase: './dist',
    port: 4008,
    stats: 'errors-only'
  },

  mode,

  entry: './src/Main.purs',

  output: {
    library: 'DukkhaLess',
    path: __dirname + '/dist',
    pathinfo: true,
    filename: 'static/js/app.[hash].js'
  },

  module: {
    rules: [
      {
        test: /\.purs$/,
        use: [
          {
            loader: 'purs-loader',
            options: {
              src: ['src/**/*.purs'],
              bundle: true,
              spago: true,
              watch: isWebpackDevServer || isWatch
            }
          }
        ]
      }
    ]
  },

  resolve: {
    modules: ['node_modules'],
    extensions: ['.purs', '.js']
  },

  plugins: [
    new webpack.LoaderOptionsPlugin({
      debug: true
    }),
    new HtmlWebpackPlugin({ template: './index.html' }),
    new CopyPlugin([{ from: './static/assets', to: './static/assets' }])
  ].concat(plugins)
}
