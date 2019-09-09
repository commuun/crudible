require 'spec_helper'

RSpec.describe Crudible::MoveMenu, type: :helper do
  include_context 'view helpers'

  let(:user) { User.create }

  let(:move_menu) do
    Crudible::MoveMenu.new(user, template: self)
  end

  # rubocop:disable Metrics/LineLength
  it 'renders the move_menu' do
    expect(move_menu.render).to eq(
      %(<a class=" " rel="nofollow" data-method="PUT" href="/users/1/move?direction=to_top">bovenste</a><a class=" " rel="nofollow" data-method="PUT" href="/users/1/move?direction=higher">omhoog</a><a class=" " rel="nofollow" data-method="PUT" href="/users/1/move?direction=lower">omlaag</a><a class=" " rel="nofollow" data-method="PUT" href="/users/1/move?direction=to_bottom">onderste</a>)
    )
  end
  # rubocop:enable Metrics/LineLength
end
