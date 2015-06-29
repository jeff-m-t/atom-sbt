AtomSbtView = require './atom-sbt-view'
SbtLogView = require './sbt-log-view'
{CompositeDisposable} = require 'atom'
spawn = require('child_process').spawn
os = require('os')
path = require 'path'

module.exports = AtomSbt =
  atomSbtView: null
  sbtPanel: null
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-sbt:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-sbt:clearSbtOutput': => @clearSbtOutput()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-sbt:runCommand': => @runCommand()

  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  toggle: ->
    console.log 'AtomSbt: Toggled'

  clearSbtOutput: ->
    console.log 'AtomSbt: SBT Output Cleared'
    @sbtLogView.clear()

  runCommand: ->
    console.log 'AtomSbt: Running Command'

    @sbtLogView = new SbtLogView()
    pane = atom.workspace.getActivePane()
    pane.addItem @sbtLogView
    pane.activateItem @sbtLogView

    pid = spawn("ls",["-l", "-a", "-R"], {cwd: atom.project.getPaths()[0]})
    pid.stdout.on 'data', (chunk) -> console.log(chunk.toString('utf8'))
    pid.stderr.on 'data', (chunk) -> console.log(chunk.toString('utf8'))
    pid.stdout.on 'data', (chunk) => @renderLines('INFO:  ', chunk.toString('utf8'))
    pid.stderr.on 'data', (chunk) => @renderLines('ERROR: ', chunk.toString('utf8'))
    pid.stdin.end()

  renderLines: (heading, chunk) ->
    for line in chunk.split(new RegExp(os.EOL, "g"))
      @sbtLogView.addRow(heading + line)
