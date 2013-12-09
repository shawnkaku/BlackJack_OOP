require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'card'

class Blackjack

  def initialize
    puts "============= Strat the BlackJack Game ============="
    puts "How many decks in this game?"
    @DK = Deck.new(gets.chomp.to_i)
    puts "Welcome to the BlackJack game. What's your name?"
    @Player1 = Player.new(gets.chomp.to_s)
    @Dealer = Dealer.new
  end

  def Run
    choice = 1
    while choice == 1
      @DK.hit(@Player1, true)
      @DK.hit(@Dealer, false)
      if @Player1.status == "BST"
        choice = 2
        puts "#{@Player1.name} is bust."
      else
        choice = @DK.choice
      end
      case
        when choice == 1
          if @DK.hit(@Player1, true)
            @Player1.status = "BST"
          end
        when choice == 2
          @DK.stay(@Player1)
          # turn to dealer to do something
          loop do @DK.hit(@Dealer, true)
          break if (@Dealer.dealer_rule(@DK.player_point(@Dealer)) == true)
          end
          # Compare which one is the winner in this turn
          player_h = {@Player1.name => @DK.player_point(@Player1), @Dealer.name => @DK.player_point(@Dealer)}
          #puts "This round winner is #{BJ.winner(player_h)}."
          @Player1.init()
          @Dealer.init()
          @DK.init_new(@Player1, @Dealer)
        when choice == 3
          @DK.quit(@Player1)
        else
          puts "You didn't Enter any choice. Please Enter 1, 2, or 3."
      end
    end
  end
end

BJ = Blackjack.new
BJ.Run

