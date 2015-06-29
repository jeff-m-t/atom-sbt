$ = require 'jquery'

module.exports =
class AtomSbtView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('atom-sbt')

    @clear()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  clear: ->
    # Clear the current logs
    $(@element).empty()

    # Create line
    message = document.createElement('div')
    message.textContent = "SBT Output:"
    message.classList.add('message')
    @element.appendChild(message)

  addRow: (row) ->
    newElement = document.createElement('div')
    newElement.classList.add('message')
    newElement.textContent = row
    @element.appendChild(newElement)
