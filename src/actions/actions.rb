require_relative "./../model/state"
require "ruby2d"

module Actions
  def self.move_snake(state)
    curr_direction = state.curr_direction
    next_position = calc_next_position(state)
    # check if still valid
    if position_still_valid?(state, next_position)
      # else move snake
      move_snake_to(state, next_position)
    else
      # if not then game over
      end_game(state)
    end
  end

  def self.change_direction(state, direction)
    puts "entro"
    if next_direction_is_valid?(state, direction)
      puts "entro a cambio"
      state.curr_direction = direction
    else
      puts "Invalid direction"
    end
    state
  end

  private

  def self.calc_next_position(state)
    curr_position = state.snake.positions.first
    case state.curr_direction
    when Model::Direction::UP
      # decrementar fila
      return Model::Coord.new(curr_position.row - 1,
                              curr_position.col)
    when Model::Direction::RIGHT
      # incrementar col
      return Model::Coord.new(curr_position.row,
                              curr_position.col + 1)
    when Model::Direction::DOWN
      # incrementar fila
      return Model::Coord.new(curr_position.row + 1,
                              curr_position.col)
    when Model::Direction::LEFT
      # decrementar col
      return Model::Coord.new(curr_position.row,
                              curr_position.col - 1)
    end
  end

  def self.position_still_valid?(state, position)
    # verificar q este en la grilla
    is_invalid = ((position.row >= state.grid.rows || position.row < 0) ||
                  (position.col >= state.grid.cols || position.col < 0))
    return false if is_invalid
    # verificar q no este superponiendo a la serpiente
    return !(state.snake.positions.include? position)
  end

  def self.move_snake_to(state, next_position)
    #
    # [(1,1), (1,0)]
    new_positions = [next_position] + state.snake.positions[0...-1]
    state.snake.positions = new_positions
    state
  end

  def self.end_game(state)
    state.game_over = true
    state
  end

  def self.next_direction_is_valid?(state, direction)
    is_valid = true
    case state.curr_direction
    when Model::Direction::UP
      is_valid = false if direction == Model::Direction::DOWN
      return is_valid
    when Model::Direction::DOWN
      is_valid = false if direction == Model::Direction::UP
      return is_valid
    when Model::Direction::LEFT
      is_valid = false if direction == Model::Direction::RIGHT
      return is_valid
    when Model::Direction::RIGHT
      is_valid = false if direction == Model::Direction::LEFT
      return is_valid
    else
      return is_valid
    end
  end
end
