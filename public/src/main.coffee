$ ->
  $('#parse').click ->
    model = SimpleRegexpModelParser.parse $('#description').val()
    $('#result').text JSON.stringify(model)
    SimpleD3Renderer.render(model)
