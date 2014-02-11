# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('textarea.wysiwyg').wysiwyg
    css: '/wysiwyg.css'
    resizeOptions: true
    controls:
      html: { visible: true }
      insertTable: { visible: false }
      removeFormat: { visible: false }
