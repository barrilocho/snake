require "minitest/autorun"
require_relative "../src/actions/actions"
require_relative "../src/model/state"

class ActionsTest < Minitest::Test
  def setup
    @initial_state = Model::State.new(
      Model::Snake.new([
        Model::Coord.new(1, 1),
        Model::Coord.new(0, 1),
      ]),
      Model::Food.new(8, 8),
      Model::Grid.new(16, 16),
      Model::Direction::DOWN,
      false
    )
  end

  def test_move_snake
    expected_state = Model::State.new(
      Model::Snake.new([
        Model::Coord.new(2, 1),
        Model::Coord.new(1, 1),
      ]),
      Model::Food.new(8, 8),
      Model::Grid.new(16, 16),
      Model::Direction::DOWN,
      false
    )

    actual_state = Actions::move_snake(@initial_state)
    assert_equal actual_state, expected_state
  end

  def test_change_direction_invalid
    expected_state = Model::State.new(
      Model::Snake.new([
        Model::Coord.new(1, 1),
        Model::Coord.new(0, 1),
      ]),
      Model::Food.new(8, 8),
      Model::Grid.new(16, 16),
      Model::Direction::DOWN,
      false
    )

    actual_state = Actions::change_direction(@initial_state, Model::Direction::UP)
    puts actual_state
    puts expected_state
    assert_equal actual_state, expected_state
  end

  def test_change_direction_valid
    expected_state = Model::State.new(
      Model::Snake.new([
        Model::Coord.new(1, 1),
        Model::Coord.new(0, 1),
      ]),
      Model::Food.new(8, 8),
      Model::Grid.new(16, 16),
      Model::Direction::LEFT,
      false
    )

    actual_state = Actions::change_direction(@initial_state, Model::Direction::LEFT)
    assert_equal actual_state, expected_state
  end

  def test_valid_direction
    valid = true

    next_direction_left = Actions::next_direction_is_valid?(@initial_state, Model::Direction::LEFT)
    next_direction_right = Actions::next_direction_is_valid?(@initial_state, Model::Direction::RIGHT)
    next_direction_up = Actions::next_direction_is_valid?(@initial_state, Model::Direction::UP)

    assert_equal valid, next_direction_left
    assert_equal valid, next_direction_right
    assert_equal valid, !next_direction_up
  end
end
