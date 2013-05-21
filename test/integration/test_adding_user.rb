require_relative '../test_helper'

class TestAddingUser < Test::Unit::TestCase
  include DatabaseCleaner

  def test_takes_arguments_and_saves_them
    assert_equal User.count, 0
    user = User.create(name: 'Steve')
    assert_equal User.count, 1
  end

  def test_takes_arguments_and_uses_them
    `ruby ktb add Jim`
    assert_equal 'Jim', User.last.name
  end

  def test_duplicate_names_are_ignored
    User.create( name: 'Gor' )
    original_user_count = User.count
    `ruby ktb add Gor`
    assert_equal original_user_count, User.count
  end

  def test_duplicate_names_outputs_error_message
    User.create( name: 'Gor' )
    results = `ruby ktb add Gor`
    assert results.include?('Name must be unique'), "Actually was '#{results}'"
  end

end