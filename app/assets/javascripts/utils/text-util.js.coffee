# -- Display Util -- #

class @TextUtil
  @extractURLs = (text) ->
    text.match(/[-a-zA-Z0-9@:%_\+.~#?&//=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?/gi)

  @buildUrls = (string) ->
    # Needs to be added
