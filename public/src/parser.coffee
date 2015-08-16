linkPatterns = [
  {
    pattern: /'(\w+)' is a '(\w+)'/g
    extract: (matched, map) ->
      new Domain.Link(map[matched[1]], map[matched[2]], Domain.LinkType.G)
  },
  {
    pattern: /'(\w+)' has a '(\w+)'/g
    extract: (matched, map) ->
      new Domain.Link(map[matched[1]], map[matched[2]], Domain.LinkType.C)
  },
  {
    pattern: /'(\w+)' uses '(\w+)'/g
    extract: (matched, map) ->
      new Domain.Link(map[matched[1]], map[matched[2]], Domain.LinkType.U)
  }
]

parseEntitiesToLabelIdMap = (text) ->
  id = 0
  result = {}
  pattern = /'(\w+)'/g
  while (matched = pattern.exec(text))
    result[matched[1]] ?= id++
  result

parseLinks = (text, entityLabelIdMap) ->
  result = []
  for p in linkPatterns
    while (matched = p.pattern.exec(text))
      result.push p.extract(matched, entityLabelIdMap)
  result

window.SimpleRegexpModelParser =
  parse: (text) ->
    entityLabelIdMap = parseEntitiesToLabelIdMap text
    entities = (new Domain.Entity(id, label) for own label, id of entityLabelIdMap)
    links = parseLinks text, entityLabelIdMap
    new Domain.Model entities, links
