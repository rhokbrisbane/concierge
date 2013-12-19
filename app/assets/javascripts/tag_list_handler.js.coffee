class TagListHandler
  constructor : ($entityTagsList, $tagsList, $addTagUrl) ->
    @entityTagsList = JSON.parse($entityTagsList.val())
    @tagsList       = JSON.parse($tagsList.val())
    @addTagUrl      = $addTagUrl.val()
    @setupSelect()
    @setupCurrentTags()
    @bindPlusButton()

  setupSelect : ->
    $("#tag_id").empty()
    html = ""
    for tag in @getCurrentTagList()
      html += "<option value=\"#{tag[0]}\">#{tag[1]}</option>"
    $("#tag_id").html(html)

  setupCurrentTags : ->
    $(".current_tags").empty()
    html = ""
    for tag in @entityTagsList
      console.log tag
      html += "<a class=\"tag\" data-id=\"#{tag[0]}\" href=\"/tags/#{tag[0]}\">#{tag[1]}</a>&nbsp;"
    $(".current_tags").html(html)

  getCurrentTagList : ->
    return _.difference(@tagsList, @entityTagsList)

  getChosenTag : (tagId)->
    for tag in @tagsList
      return tag if tag[0] == tagId

  bindPlusButton : ->
    $("#submit_new_tag").off('click')
    $("#submit_new_tag").on 'click', (e) =>
      e.preventDefault()
      tagId = parseInt($("#tag_id").val())
      @entityTagsList.push(@getChosenTag(tagId))
      @setupSelect()
      @setupCurrentTags()
      @addTag(tagId)

  addTag : (tagId) ->
    _this = @
    $.ajax
      url: _this.addTagUrl
      type: "PATCH"
      data: { tag_id: tagId}
      dataType: "json"
      success: (data) ->

$ ->
  if ($("#entity_tags_list").length && $("#tags_list").length && $("#add_tag_url").length)
    tlh = new TagListHandler($("#entity_tags_list"), $("#tags_list"), $("#add_tag_url"))
