require 'pry'
class TicTacToe

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(space, token='X')
        @board[space] = token
    end

    def position_taken?(space)
        @board[space] == 'X' || @board[space] == 'O'
    end

    def valid_move?(space)
        space >= 0 && space <= 8 && !position_taken?(space)
    end

    def turn_count
        @board.count{|token| token == 'X' || token == 'O'}
    end

    def current_player
        turn_count % 2 == 0 ? 'X' : 'O'
    end

    def turn
        puts "Please enter 1-9:"
        space = input_to_index(gets.chomp)
        if valid_move?(space) && !position_taken?(space)
            move(space, current_player)
        else
            turn
        end
        display_board
    end

    def won?
        WIN_COMBINATIONS.each do |wins|
            if @board[wins[0]] == @board[wins[1]] && @board[wins[1]] == @board[wins[2]] && position_taken?(wins[0])
                return wins
            end
        end
        return false
    end

    def full?
        @board.each do |space|
            return false if space == " "
        end
        return true
    end

    def draw?
        return true if full? && !won?
    end

    def over?
        return true if full? || won?
    end

    def winner
        won? ? @board[won?[0]] : nil 
    end

    def play
        while !over? && !draw? do
            turn
            if b = won?
                puts "Congratulations #{@board[b[0]]}!"
            elsif draw?
                puts "Cat's Game!"
            end
        end
    end

end