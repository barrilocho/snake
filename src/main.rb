require_relative "view/grid"
require_relative "model/state"
require_relative "actions/actions"

class App
  def initialize
    @state = Model::initial_state
  end

  def start
    @view = View::Grid.new(self)
    initial_state = Model::initial_state
    timer_thread = Thread.new { init_timer(@view) }
    @view.start(@state)
    timer_thread.join
  end

  def init_timer(view)
    loop do
      #trigger movement
      if @state.game_over
        puts "juego finalizado"
        puts "Puntaje: #{@state.snake.positions.length}"
        break
      end
      @state = Actions::move_snake(@state)
      view.render(@state)
      sleep 0.1
    end
  end

  def send_action(action, params)
    # :change_direction, Model::Direction::UP
    new_state = Actions.send(action, @state, params)
    if new_state.hash != @state
      @state = new_state
      @view.render(@state)
    end
  end
end

app = App.new
app.start
