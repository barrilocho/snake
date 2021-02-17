require "ruby2d"
require_relative "../model/state"
require_relative "../actions/actions"

module View
  class Grid
    # attr_accessor (pixel_size)
    def initialize(app)
      @app = app
      @pixel_size = 50
    end

    def start(state)
      extend Ruby2D::DSL
      set(
        title: "Snake",
        width: @pixel_size * state.grid.cols,
        height: @pixel_size * state.grid.rows,
      )
      on :key_down do |event|
        # A key was pressed
        handle_key_event(event)
      end
      show
    end

    def render(state)
      extend Ruby2D::DSL
      close if state.game_over
      render_snake(state)
      render_food(state)
    end

    def render_food(state)
      @food.remove if @food
      extend Ruby2D::DSL
      food = state.food
      @food = Square.new(y: food.row * @pixel_size, x: food.col * @pixel_size, size: (@pixel_size - 5), color: "yellow")
    end

    def render_snake(state)
      @snake_positions.each(&:remove) if @snake_positions

      extend Ruby2D::DSL
      snake = state.snake
      @snake_positions = snake.positions.map do |position|
        Square.new(y: position.row * @pixel_size, x: position.col * @pixel_size, size: (@pixel_size - 5), color: "brown")
      end
      # for position in snake.positions do
      #   Square.new(x: position.row*@pixel_size, y: position.col*@pixel_size,  size: @pixel_size)
      # end
    end

    def pixel_size
    end

    private

    def handle_key_event(event)
      case event.key
      when "right"
        @app.send_action(:change_direction, Model::Direction::RIGHT)
        # Actions::change_direction(state, Model::Direction::RIGHT)
      when "left"
        @app.send_action(:change_direction, Model::Direction::LEFT)
        # Actions::change_direction(state, Model::Direction::LEFT)
      when "up"
        @app.send_action(:change_direction, Model::Direction::UP)
        # Actions::change_direction(state, Model::Direction::UP)
      when "down"
        @app.send_action(:change_direction, Model::Direction::DOWN)
        # Actions::change_direction(state, Model::Direction::DOWN)
      end
    end
  end
end
