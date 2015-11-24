{View} = require 'space-pen'

module.exports =
class InputView extends View
  @content: ->
    @div class: "atom-cscope-input", =>
      @div class: "inline-block", id: "form-container", =>
        @select id: "cscope-options", =>
          @option value: '0', "Find this C symbol"
          @option value: '1', "Find this global deffgfgion"
          @option value: '2', "Find functions called by this"
          @option value: '3', "Find functions calling this"
          @option value: '4', "Find this text string"
          @option value: '5', "Find this egrep pattern"
          @option value: '6', "Find this file"
          @option value: '7', "Find files #including this file"
          @option value: '8', "Find assignments to this symbol"
        @button class: "btn", id: "search", "Do It!"

  initialize: (params) ->
    @find('div#form-container select').after('<atom-text-editor id="search-keyword" mini placeholder="Something you typed..."></atom-text-editor>')
    @editor = @find('atom-text-editor#search-keyword')[0]
    @editor.getModel().setPlaceholderText("Write something!")
    
  getSearchKeyword: ->
    return @editor.getModel().getText()
    
  getSelectedOption: ->
    return parseInt(@find('select#cscope-options').val())
    
  onSearch: (callback) ->
    @editor.getModel().onDidStopChanging () =>
      callback()
    @on 'click', 'button#search', =>
      callback()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element