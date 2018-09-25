require 'test_plugin_helper'

class ForemanM2Test < ActiveSupport::TestCase
  setup do
    User.current = User.find_by login: 'admin'
  end

  test 'truth' do
    assert_kind_of Module, ForemanM2
  end

  test 'proxy url saved in CR' do
    m2 = FactoryBot.create(:compute_resource, :m2)
    assert m2.url == 'http://127.0.0.1:1234'
  end
end
