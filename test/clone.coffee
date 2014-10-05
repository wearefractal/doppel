should = require 'should'
clone = require '../lib'
path = require 'path'
rimraf = require 'rimraf'

describe 'clone', ->

  after (done) ->
    rimraf path.resolve('./test/tmp'), (err) -> 
      console.log err if err?
      done()
 
  it 'should parse and copy', (done) ->

    sandbox =
      name: 'boba'

    clone path.resolve('./test/templates'), path.resolve('./test/tmp'), sandbox, ->      
      data = require './tmp/hi'
      data.should.equal 'hi boba'
      done()

  it 'should parse and copy nested', (done) ->

    data = require './tmp/client/app'
    data.should.equal 'some app boba'
    done()