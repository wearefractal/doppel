path        = require 'path'
fs          = require 'fs'
mkdirp      = require 'mkdirp'
clone       = require './index'
interpolate = require './interpolate'
log         = console

# parse template, apply sandbox vars
module.exports = (from, to, sandbox, file, next) -> 

  from  = path.join from, file
  to    = path.join to, file

  fs.stat from, (err, stat) ->
    if stat.isDirectory()
      mkdirp to, (err) -> 
        log.err "mkdir: #{err}" if err?
        require('./index') from, to, sandbox
        next()
    else
      mkdirp path.dirname(to), (err) ->
        return next err if err?
        fs.readFile from, (err, data) ->
          data = interpolate data.toString(), sandbox
          fs.writeFile to, data, (err) -> 
            return next log.error err if err?
            next()