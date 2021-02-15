require "ruby2d"
module View 
  class Grid
    def initialize
      @pixel_size = 50
    end

    def render(state)
      extend Ruby2D::DSL
      set(
        title: "Snake", 
        width: @pixel_size * state.grid.cols, 
        height: @pixel_size * state.grid.rows)
      render_snake(state)
      render_food(state)
      show
    end
    def render_food(state)
      Square.new(x: state.food.row*@pixel_size, y: state.food.col*@pixel_size,  size: @pixel_size)
    end
    def render_snake(state)
      for position in state.snake.positions do
        Square.new(x: position.row*@pixel_size, y: position.col*@pixel_size,  size: @pixel_size)
      end
    end
  end
end