require "ruby2d"
module View 
  class Grid
    # attr_accessor (pixel_size)
    def initialize
      @pixel_size = 50
    end

    def start(state)
      extend Ruby2D::DSL 
      set(
        title: "Snake",
        width: @pixel_size * state.grid.cols,
        height: @pixel_size * state.grid.rows
      )
      show
    end

    def render(state)
      render_snake(state)
      render_food(state)
    end
    def render_food(state)
      extend Ruby2D::DSL
      food = state.food
      Square.new(y: food.row*@pixel_size, x: food.col*@pixel_size,  size: @pixel_size, color: 'yellow')
    end
    def render_snake(state)
      extend Ruby2D::DSL
      snake = state.snake
      snake.positions.each do |position|
        Square.new(y: position.row*@pixel_size, x: position.col*@pixel_size,  size: @pixel_size, color: 'brown')
 
      end

      # for position in snake.positions do
      #   Square.new(x: position.row*@pixel_size, y: position.col*@pixel_size,  size: @pixel_size)
      # end
    end
    def pixel_size
    end

  end
end