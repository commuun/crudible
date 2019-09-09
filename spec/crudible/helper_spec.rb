require 'spec_helper'

RSpec.describe Crudible::Helper, type: :helper do
  include_context 'view helpers'

  describe '#human_resource_name' do
    it 'returns the humanized resource name' do
      expect(helper.human_resource_name).to eq('Gebruiker')
    end
  end

  describe '#human_resources_name' do
    it 'returns the pluralized humanized resource name' do
      expect(helper.human_resources_name).to eq('Gebruikers')
    end
  end

  describe '#attribute_name' do
    it 'returns the resource humanized attribute name' do
      expect(helper.attribute_name(:first_name)).to eq('Voornaam')
    end
  end

  describe '#new_resource_link' do
    it 'returns a link to a new resource' do
      expect(helper.new_resource_link).to eq(
        '<a class="" href="/users/new">toevoegen</a>'
      )
    end
  end

  describe '#resource_menu' do
    it 'renders the resource context menu' do
      resource_menu = double(Crudible::ResourceMenu)

      allow(Crudible::ResourceMenu).to receive(:new).and_return(resource_menu)
      expect(resource_menu).to receive(:render).and_return('rendered')

      expect(helper.resource_menu(:user, template: self)).to eq('rendered')
    end
  end

  describe '#move_menu' do
    it 'renders the resource context menu' do
      move_menu = double(Crudible::MoveMenu)

      allow(Crudible::MoveMenu).to receive(:new).and_return(move_menu)
      expect(move_menu).to receive(:render).and_return('rendered')

      expect(helper.move_menu(:user, template: self)).to eq('rendered')
    end
  end
end
