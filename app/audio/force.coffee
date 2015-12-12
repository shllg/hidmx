module.exports = class Force extends Backbone.Model

  initialize: (attrs, options) =>
    @env = options.env