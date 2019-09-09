require 'spec_helper'

RSpec.describe Crudible::Controller::Sortable, type: :controller do
  controller(UsersController) do
    include Crudible::Controller::Base
    include Crudible::Controller::Sortable
  end

  let(:user) { User.create }

  describe '#after_move_path' do
    it 'returns the current resource\'s "index" path' do
      expect(controller.send(:after_move_path)).to eq(['users'])
    end
  end

  context 'with direction' do
    describe '#direction' do
      %w[higher lower to_top to_bottom].each do |direction|
        it "returns #{direction}" do
          controller.params[:direction] = direction
          expect(controller.send(:direction)).to eq(direction)
        end
      end

      it 'returns nil if no valid direction was provided' do
        expect(controller.send(:direction)).to be nil
      end
    end
  end
end
