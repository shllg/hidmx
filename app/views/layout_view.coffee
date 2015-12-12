module.exports = class LayoutView extends Marionette.LayoutView

  template: tpl(__dirname, '../templates/layout_view.jade')

  ui:
    tabLinks:         '#tabs-nav a'
    tabContainers:    '#tabs-container > .tab'
    tabsContainer:    '#tabs-container'
    tabControls:      '#tab-controls'
    tabSoundAnalyze:  '#tab-sound-analyze'

  events:
    'click @ui.tabLinks': 'onClickTab'

  initialize: (options) =>
    @env = options.env

  onClickTab: (event) =>
    event.preventDefault()
    target = $(event.target)

    @_resetStates()
    @_enableTab(target)

  onRender: =>
    views = [
      @env.getDevice('ledBar001').getPreviewView(),
      @env.getDevice('ledBar001').getControlsView(),
      @env.getDevice('adjRevo001').getPreviewView(),
      @env.getDevice('adjRevo001').getControlsView(),
      @env.getDevice('adjQuadPhase001').getPreviewView(),
      @env.getDevice('adjQuadPhase001').getControlsView(),
    ]

    _.each views, (view) =>
      @ui.tabControls.append(view.$el)
      view.render()

  # ---------------------------------------------
  # private methods

  # @nodoc
  _resetStates: =>
    @ui.tabLinks.removeClass('tab-active')
    @ui.tabContainers.removeClass('tab-active')

  # @nodoc
  _enableTab: (element) =>
    $(element.data('id'), @ui.tabsContainer).addClass('tab-active')
    element.addClass('tab-active')


