
getResults = (tagIds) ->

  handleRequest = (data, type) ->
    _.each data, (result, i) ->
      if result.address and result.address.latitude
        address = result.address
        icon = L.divIcon({className: "marker icon-#{type}"})
        marker = L.marker([address.latitude, address.longitude], icon: icon)
        marker.bindPopup(HandlebarsTemplates["#{type}_popup"](result))
        layer.push marker

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

  window.layer = []

  $.when(resourcesRequest, peopleRequest).done (resources, users) ->
    handleRequest(resources[0].search, 'resource')
    handleRequest(users[0].search, 'user')

    markers = new L.MarkerClusterGroup()
    markers.addLayers layer
    map.addLayer markers
    map.fitBounds markers.getBounds()

$ ->

  if $('#results-map').length
    bounds = [ [-29.726222319395504, 125.5078125], [-10.01212955790814, 163.4765625] ]
    window.map = new L.Map("results-map").fitBounds(bounds)
    # new L.TileLayer.Stamen({style: 'watercolor'}).addTo(map)
    new L.TileLayer.MapBox({user: 'concierge', map: 'gjdmmp09'}).addTo(map)

    if $('#result-tag-ids').val().length
      getResults( $('#result-tag-ids').val().split(',') )
