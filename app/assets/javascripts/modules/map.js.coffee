
getResults = (tagIds) ->

  $.ajaxSetup
    async: false

  window.layer = new L.MarkerClusterGroup()

  handleRequest = (data, type) ->
    _.each data, (result, i) ->
      if result.address
        console.log result
        address = result.address
        icon = L.divIcon({className: "marker icon-#{type}"})
        marker = L.marker([address.latitude, address.longitude], icon: icon)
        marker.bindPopup(HandlebarsTemplates["#{type}_popup"](result))
        marker.addTo(layer)

  resourcesRequest = $.ajax
    type: "POST"
    url: '/api/v1/search/resources',
    data:
      tag_ids: tagIds

  peopleRequest = $.ajax
    type: "POST"
    url: '/api/v1/search/people',
    data:
      tag_ids: tagIds

  resourcesRequest.done (data) ->
    handleRequest(data.search, 'resource')

  peopleRequest.done (data) ->
    handleRequest(data.search, 'user')

  map.addLayer layer
  map.fitBounds layer.getBounds()

$ ->

  if $('#results-map').length
    bounds = [ [-29.726222319395504, 125.5078125], [-10.01212955790814, 163.4765625] ]
    window.map = new L.Map("results-map").fitBounds(bounds)
    # new L.TileLayer.Stamen({style: 'watercolor'}).addTo(map)
    new L.TileLayer.MapBox({user: 'concierge', map: 'gjdmmp09'}).addTo(map)

    getResults( $('#result-tag-ids').val().split(',') ) if $('#results-map').length
