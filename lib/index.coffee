async = require 'async'
fs    = require 'fs'
parse = require './parse'
log   = console

module.exports = (from, to, sandbox, next) ->

  fs.readdir from, (err, files) -> 
    next log.error "couldn't read #{from}: #{err}" if err?
    fn = async.apply parse, from, to, sandbox 
    async.forEach files, fn, (next if next?)