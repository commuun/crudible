require 'spec_helper'

RSpec.describe Crudible::Helper, type: :helper do
  around do |example|
    I18n.with_locale(:nl) do
      without_partial_double_verification { example.run }
    end
  end

  before do
    Crudible.configure {}
    allow(helper).to receive(:resource_base_path).and_return([])
    allow(helper).to receive(:resource_name).and_return('user')
    allow(helper).to receive(:resource_class).and_return(User)
  end

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
end
