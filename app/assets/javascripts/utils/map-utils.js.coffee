# -- Map Utils -- #

class @MapUtils
  @getCurrentLocation : (cb) ->
    if localStorage && localStorage.getItem('current_location')
      latlng = _.map localStorage.getItem("current_location").split(","), (item) ->
        parseFloat(item)
      cb(latlng)
    else
      $.getJSON "https://freegeoip.net/json/?callback=?", (data) ->
        latlng = [data.latitude, data.longitude]
        localStorage.setItem('current_location', latlng)
        cb(latlng)
