should = require 'should'
parse = require '../lib/parse'
path = require 'path'
rimraf = require 'rimraf'

describe 'parse', ->

  after (done) ->
    rimraf path.resolve('./test/tmp'), (err) -> 
      console.log err if err?
      done()
 
  it 'should parse and copy', (done) ->

    sandbox =
      name: 'boba'

    parse path.resolve('./test/templates'), path.resolve('./test/tmp'), sandbox, 'hi.coffee', ->
      data = require './tmp/hi'
      data.should.equal 'hi boba'
      done()