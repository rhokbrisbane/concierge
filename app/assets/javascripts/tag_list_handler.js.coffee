class TagListHandler
  constructor : ($entityTagsList, $tagsList, $addTagUrl, $removeTagUrl) ->
    @entityTagsList = JSON.parse($entityTagsList.val())
    @tagsList       = JSON.parse($tagsList.val())
    @addTagUrl      = $addTagUrl.val()
    @removeTagUrl   = $removeTagUrl.val()
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
      html += "
        <div class='tag' data-id=#{tag[0]}>
          <a class='name' href='/tags/#{tag[0]}'>#{tag[1]}</a>&nbsp;
          <a class='remove' href='#' rel='nofollow' data-turbolinks-track=false>x</a>
        </div>&nbsp;
      "
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
      data: { tag_id: tagId }
      dataType: "json"
      success: () ->

  @removeTag : (e) ->
    e.preventDefault()
    tagId = $(this).parent().data('id')
    removeTagUrl = $('#remove_tag_url').val()
    _this = @
    $.ajax
      url: removeTagUrl
      type: "PATCH"
      data: { tag_id: tagId }
      dataType: "json"
      success: () ->
        tagId = this.data.split('=')[1]
        name = $(".tag[data-id=#{tagId}] .name").html()
        $("select#tag_id").append("<option value=#{tagId}>#{name}</option>")
        $(".tag[data-id=#{tagId}]").remove()

$ ->
  if ($("#entity_tags_list").length && $("#tags_list").length && $("#add_tag_url").length && $("#remove_tag_url").length)
    tlh = new TagListHandler($("#entity_tags_list"), $("#tags_list"), $("#add_tag_url"), $("#remove_tag_url"))
  $('.tag a.remove').on 'click', TagListHandler.removeTag
