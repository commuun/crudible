require 'spec_helper'

RSpec.describe Crudible::Helpers::MoveMenu, type: :helper do
  include_context 'view helpers'

  let(:user) { User.all[1] }

  let(:move_menu) do
    Crudible::Helpers::MoveMenu.new(user, template: helper)
  end

  before do
    3.times { User.create }
  end

  # rubocop:disable Metrics/LineLength
  it 'renders the move_menu' do
    expect(move_menu.render).to eq(
      %(<a class="move move__to_top" rel="nofollow" data-method="PUT" href="/users/#{user.id}/move?direction=to_top">bovenste</a>) +
      %(<a class="move move__higher" rel="nofollow" data-method="PUT" href="/users/#{user.id}/move?direction=higher">omhoog</a>) +
      %(<a class="move move__lower" rel="nofollow" data-method="PUT" href="/users/#{user.id}/move?direction=lower">omlaag</a>) +
      %(<a class="move move__to_bottom" rel="nofollow" data-method="PUT" href="/users/#{user.id}/move?direction=to_bottom">onderste</a>)
    )
  end
  # rubocop:enable Metrics/LineLength
end
