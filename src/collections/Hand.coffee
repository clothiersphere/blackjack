class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @logic()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  stand: ->
    @.models[0].flip()
    @dealerLogic()

  logic: ->

    if @scores()[0] == 21 or @scores()[1] == 21
      if @isDealer
        @lose()
      else
        @win()
    else if @scores()[0] > 21
      @bust()

  bust: ->
    alert 'Reconsider life decisions because you lost'
    @trigger 'bust', @

  win: ->
    alert 'You degenerate gambler you, You\'re a winner!11111'
    @trigger 'win', @

  push: ->
    alert 'Don\'t you just love a lil pushin'
    @trigger 'push', @

  dealerLogic: ->
    if @scores() < 17
      @hit()
      @dealerLogic()
    else
      trigger 'compare', @

  lose: ->
    alert 'Did you really think you could ever win?'
    @trigger 'lose',@
