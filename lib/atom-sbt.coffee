AtomSbtView = require './atom-sbt-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomSbt =
  atomSbtView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomSbtView = new AtomSbtView(state.atomSbtViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomSbtView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-sbt:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomSbtView.destroy()

  serialize: ->
    atomSbtViewState: @atomSbtView.serialize()

  toggle: ->
    console.log 'AtomSbt was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
