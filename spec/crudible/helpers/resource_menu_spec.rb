require 'spec_helper'

RSpec.describe Crudible::Helpers::ResourceMenu, type: :helper do
  include_context 'view helpers'

  let(:user) { User.create }

  let(:resource_menu) do
    Crudible::Helpers::ResourceMenu.new(user, template: helper)
  end

  # rubocop:disable Metrics/LineLength
  it 'renders the resource_menu' do
    expect(resource_menu.render).to eq(
      %(<a class="destroy" data-confirm="Weet u zeker dat u deze gebruiker wilt verwijderen?" rel="nofollow" data-method="delete" href="/users/1">verwijderen</a><a class="edit" href="/users/1/edit">wijzigen</a>)
    )
  end
  # rubocop:enable Metrics/LineLength
end
