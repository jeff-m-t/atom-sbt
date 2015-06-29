LogView = require './log-view'

module.exports =
class SbtLogView extends LogView

  @URI: "atom://arom-sbt/sbt-log"

  constructor: ->
    super(title: "SBT Output:")
