linkTypeStyles = {}
linkTypeStyles[Domain.LinkType.G] = -> {arrowhead: 'hollow'}
linkTypeStyles[Domain.LinkType.C] = -> {arrowhead: 'vee'}
linkTypeStyles[Domain.LinkType.U] = -> {arrowhead: 'vee', style: 'fill:#fff; stroke: #666; stroke-width: 1.5px; stroke-dasharray: 3,3'}

generateDiagram = (model) ->
  g = new dagreD3.graphlib.Graph().setGraph({})
  g.setDefaultEdgeLabel(-> {})
  g.setNode(entity.id, {label: entity.label}) for entity in model.entities
  g.setEdge(link.source, link.target, linkTypeStyles[link.type]()) for link in model.links
  g

getCustomizedRenderer = ->
  renderer = new dagreD3.render()

  renderer.arrows().hollow = (parent, id, edge, type) ->
    marker = parent.append("marker")
      .attr("id", id)
      .attr("viewBox", "0 0 10 10")
      .attr("refX", 9)
      .attr("refY", 5)
      .attr("markerUnits", "strokeWidth")
      .attr("markerWidth", 8)
      .attr("markerHeight", 6)
      .attr("orient", "auto")

    path = marker.append("path")
      .attr("d", "M 0 0 L 10 5 L 0 10 z")
      .style("stroke-width", 1)
      .style("stroke-dasharray", "1,0")
      .style("fill", "#fff")
      .style("stroke", "#333")
    dagreD3.util.applyStyle(path, edge[type + "Style"])

  renderer

renderer = getCustomizedRenderer()

window.SimpleD3Renderer =
  render: (model) ->
    diagram = generateDiagram(model)
    svg = d3.select("svg")
    svg.append("g")
    renderer(d3.select("svg g"), diagram)
    svg.attr("height", diagram.graph().height + 40)
