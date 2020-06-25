
# Danny's init script!
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# Useful functions
wrapHTML = (selection, tag) ->
  selection.insertText("<#{tag}>#{selection.getText()}</#{tag}>")

wrapHTMLWithClass = (selection, tag, classstr) ->
  tagwithclass = '<' + "#{tag} " + 'class="' + "#{classstr}" + '">'
  selection.insertText("#{tagwithclass}#{selection.getText()}</#{tag}>")

# Add command-pallet ability to remove various text styles
atom.commands.add 'atom-text-editor', 'remove-text-styles', ->
  editor = atom.workspace.getActiveTextEditor()
  scope = editor.getRootScopeDescriptor()
  selections = editor.getSelections()
  # are we working in htmlbook?
  if `scope  == '.text.html.basic'`
    regMatch = /\<em\>|\<\/em\>|\<code\>|\<\/code\>/g # match em and code
  else # probably markdown or asciidoc, then
    regMatch = /_|\*|`|\+/g # match emphasis, bold, and fixed-width

  striptext = (selection) ->
    selection.insertText(selection.getText().replace(regMatch, ""))

  # use the function
  for selection in selections
    striptext(selection)

# Add emphasis to text in HTML files
atom.commands.add 'atom-text-editor', 'html:add-emphasis', ->
  editor = atom.workspace.getActiveTextEditor()
  scope = editor.getRootScopeDescriptor()
  if `scope  == '.text.html.basic'`
    selections = editor.getSelections()
    for selection in selections
      wrapHTML(selection, "em")

# Add code markup to text in HTML files
atom.commands.add 'atom-text-editor', 'html:add-code-markup', ->
  editor = atom.workspace.getActiveTextEditor()
  scope = editor.getRootScopeDescriptor()
  if `scope  == '.text.html.basic'`
    selections = editor.getSelections()
    for selection in selections
      wrapHTML(selection, "code")

# Add subscript to text in HTML files
atom.commands.add 'atom-text-editor', 'html:add-subscript', ->
  editor = atom.workspace.getActiveTextEditor()
  scope = editor.getRootScopeDescriptor()
  if `scope  == '.text.html.basic'`
    selections = editor.getSelections()
    for selection in selections
      wrapHTML(selection, "sub")

# Add superscript to text in HTML files
atom.commands.add 'atom-text-editor', 'html:add-superscript', ->
  editor = atom.workspace.getActiveTextEditor()
  scope = editor.getRootScopeDescriptor()
  if `scope  == '.text.html.basic'`
    selections = editor.getSelections()
    for selection in selections
      wrapHTML(selection, "sup")

# Add superscript to text in HTML files
atom.commands.add 'atom-text-editor', 'htmlbook:keep-together', ->
  editor = atom.workspace.getActiveTextEditor()
  scope = editor.getRootScopeDescriptor()
  if `scope  == '.text.html.basic'`
    selections = editor.getSelections()
    for selection in selections
      wrapHTMLWithClass(selection, "span", "keep-together")
