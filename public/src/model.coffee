window.Domain = {}

class Domain.Entity
  constructor: (@id, @label) ->

Domain.LinkType =
  G: 'Generalization'
  U: 'Usage'
  A: 'Aggregation'
  C: 'Composition'

class Domain.Link
  constructor: (@source, @target, @type) ->

class Domain.Model
  constructor: (@entities, @links) ->
