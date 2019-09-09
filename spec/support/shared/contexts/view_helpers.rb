# frozen_string_literal: true

RSpec.shared_context 'view helpers' do
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
end
