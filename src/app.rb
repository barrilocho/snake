require_relative "view/grid"
require_relative "model/state"

view = View::Grid.new

initial_state = Model::initial_state

view.render(initial_state)

initial_stat