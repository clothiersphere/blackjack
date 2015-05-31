# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'bust win push lose', => @ourReset()
    @get('dealerHand').on 'compare', => @compareCards()

  ourReset: ->
    # @set 'deck', deck = new Deck()
    # @set 'playerHand', deck.dealPlayer()
    # @set 'dealerHand', deck.dealDealer()
    # @get('playerHand').on 'bust win push lose', => @initialize()
    # @get('dealerHand').on 'compare', => @compareCards()
    @initialize()

  compareCards: ->
    console.log 'got here in compare'
    dealer = @get ('dealerHand')
    player = @get ('playerHand')
    console.log dealer.scores()[0] + 'dealer score'
    console.log player.scores()[0] + 'player score'
    if dealer.scores()[0] > player.scores()[0] && dealer.scores()[0] <= 21
        console.log 'dealer should have won'
        player.lose()
    else player.win()

    # @get('dealerHand').on 'compare', => @compareCards()
