require 'spec_helper'

describe Crudible::Configuration do
  it 'initializes the configuration properly' do
    expect(Crudible.configuration).to be nil
    Crudible.configure {}
    expect(Crudible.configuration).not_to be nil
  end

  %i[
    new_link_class edit_link_class destroy_link_class move_link_class
    disabled_link_class
  ].each do |setting|
    describe "##{setting}" do
      it 'returns blank by default' do
        Crudible.configure {}
        expect(Crudible.configuration.public_send(setting)).to eq ''
      end

      it "returns the value set for #{setting}" do
        Crudible.configure do |config|
          config.public_send("#{setting}=", 'test value')
        end
        expect(Crudible.configuration.public_send(setting)).to eq 'test value'
      end
    end
  end

  describe '#auth_callback' do
    it 'resolves to true by default' do
      Crudible.configure {}
      expect(Crudible.configuration.auth_callback.call(nil, nil, nil))
        .to eq(true)
    end

    it 'returns false if set to return false' do
      Crudible.configure do |config|
        config.auth_callback = ->(_resource, _template, _action) { false }
      end
      expect(Crudible.configuration.auth_callback.call(nil, nil, nil))
        .to eq(false)
    end
  end
end
