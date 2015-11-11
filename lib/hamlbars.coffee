HamlbarsView = require './hamlbars-view'
{CompositeDisposable} = require 'atom'

module.exports = Hamlbars =
  hamlbarsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @hamlbarsView = new HamlbarsView(state.hamlbarsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @hamlbarsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'hamlbars:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @hamlbarsView.destroy()

  serialize: ->
    hamlbarsViewState: @hamlbarsView.serialize()

  toggle: ->
    console.log 'Hamlbars was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
