module.exports = class LayoutView extends Marionette.LayoutView

  template: tpl(__dirname, '../templates/layout_view.jade')

  ui:
    tabLinks:       '#tabs-nav a'
    tabContainers:  '#tabs-container > .tab'
    tabsContainer:  '#tabs-container'
    tabControls:      '#tab-controls'
    tabSoundAnalyze:  '#tab-sound-analyze'

  events:
    'click @ui.tabLinks': 'onClickTab'

  onClickTab: (event) =>
    event.preventDefault()
    target = $(event.target)

    @_resetStates()
    @_enableTab(target)


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


