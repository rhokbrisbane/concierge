updateMap = () ->
  markers = new L.MarkerClusterGroup()
  markers.addLayers layer

  if layer.length
    map.addLayer markers
    if $(window).outerWidth() >= 640
      padding = [$('.map-hero .results').outerWidth(), 0]
    else
      padding = [0, 0]
    map.fitBounds markers.getBounds(), { paddingBottomRight: padding }

bindAddressablePopup = (el) ->
  addressable = $(el).data().addressable
  address = addressable.address

  if address && address.latitude && address.longitude
    type = addressable.type
    icon = L.divIcon({ className: "marker icon-#{type}" })
    marker = new L.customDataMarker([address.latitude, address.longitude],
      icon: icon, map_id: addressable.id, type: type)
    marker.bindPopup(HandlebarsTemplates["#{type}_popup"](addressable))
    layer.push marker

L.customDataMarker = L.Marker.extend
  options:
    map_id: "ID for map"
    type: "Type"

addCurrentLocationMarker = (location) ->
  locationMarker = L.marker(location, icon: L.divIcon({className: "current-location icon-location"}))
  map.addLayer locationMarker

getResults = (tagIds) ->
  handleRequest = (data, type) ->
    _.each data, (result, i) ->
      if result.address and result.address.latitude
        address = result.address
        icon = L.divIcon({className: "marker icon-#{type}"})
        marker = new L.customDataMarker([address.latitude, address.longitude], icon: icon, map_id: result.id, type: type)
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

  $.when(resourcesRequest, peopleRequest).done (resources, users) ->
    handleRequest( _.uniq(resources[0].search, 'id')  , 'resource')
    handleRequest( _.uniq(users[0].search, 'id'), 'user')
    updateMap()

$ ->
  if $('#results-map').length
    bounds = [ [-29.726222319395504, 125.5078125], [-10.01212955790814, 163.4765625] ]
    window.map = new L.Map("results-map").fitBounds(bounds)
    window.layer = []

    _.each $('[data-addressable]'), bindAddressablePopup

    # new L.TileLayer.Stamen({style: 'watercolor'}).addTo(map)
    new L.TileLayer.MapBox({user: 'concierge', map: 'gjdmmp09'}).addTo(map)

    if localStorage.getItem('myLocation')
      current_location = _.map(localStorage.current_location.split(','), (item) -> return parseFloat(item))
      addCurrentLocationMarker(current_location)
    else
      @MapUtils.getCurrentLocation (location) ->
        localStorage.setItem('myLocation', location)
        addCurrentLocationMarker(location)

    if $('#result-tag-ids').length && $('#result-tag-ids').val().length
      getResults( $('#result-tag-ids').val().split(',') )

    if $('#all-resources').length
      allResources()


@allResources = ->
  resourcesRequest = $.ajax
    type: "GET"
    url: '/api/v1/resources'

  resourcesRequest.done (data) ->
    markers = new L.MarkerClusterGroup()

    $.each data.resources, (i, resource) ->
      if resource.address && resource.address.latitude
        address = resource.address
        icon = L.divIcon({className: "marker icon-resource"})
        marker = L.marker([address.latitude, address.longitude], icon: icon)
        marker.bindPopup(HandlebarsTemplates["resource_popup"](resource))
        markers.addLayer marker

    map.addLayer markers
    map.fitBounds markers.getBounds()

$(document).off 'click', '#pan-to-location'
$(document).on 'click', '#pan-to-location', (e) ->
  map.panTo( localStorage.current_location.split(',') )

$(document).off 'click', '#toggle-results'
$(document).on 'click', '#toggle-results', (e) ->
  $('.map-hero .results').toggleClass('active')




$(document).on 'click', '.icon-location[data-map-user-id]', (e) ->
  e.preventDefault()
  id = $(this).data('map-user-id')
  marker = _.find layer, (m) -> m.options.map_id == id and m.options.type == 'user'
  map.panTo marker.getLatLng()
  marker.openPopup()

$(document).on 'click', '.icon-location[data-map-resource-id]', (e) ->
  e.preventDefault()
  id = $(this).data('map-resource-id')
  marker = _.find layer, (m) -> m.options.map_id == id and m.options.type == 'resource'
  map.panTo marker.getLatLng()
  marker.openPopup()

