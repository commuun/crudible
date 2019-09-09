require 'spec_helper'

RSpec.describe Crudible::Controller::Base, type: :controller do
  controller(UsersController) do
    include Crudible::Controller::Base
  end

  let(:user) { User.create }

  describe '#resource_class' do
    it 'returns the plain name of the current resource' do
      expect(controller.send(:resource_class)).to eq(User)
    end
  end

  describe '#resource_scope' do
    it 'returns the default scope for the current resource' do
      expect(controller.send(:resource_scope)).to eq(User.all)
    end
  end

  describe '#resource_name' do
    it 'returns the plain name of the current resource' do
      expect(controller.send(:resource_name)).to eq('user')
    end
  end

  describe '#resources_name' do
    it 'returns the plain name of the current resource' do
      expect(controller.send(:resources_name)).to eq('users')
    end
  end

  describe '#resources' do
    it 'returns all resources for the current controller' do
      expect(controller.send(:resources)).to eq(User.all)
    end
  end

  describe '#resource_params' do
    it 'raises an error if not implemented in the child controller' do
      expect { controller.send(:resource_params) }
        .to raise_error NotImplementedError
    end
  end

  context 'with a specific resource' do
    controller(UsersController) do
      include Crudible::Controller::Base

      def resource_params
        return if params[:user].blank?

        params.require(:user).permit(:email)
      end
    end

    describe '#resource' do
      it 'returns the current resource' do
        controller.params[:id] = user.id
        expect(controller.send(:resource)).to eq(user)
      end

      it 'returns a new resource' do
        allow(controller).to receive(:action_name).and_return('new')
        expect(controller.send(:resource).new_record?).to be true
      end

      it 'returns the updated resource' do
        controller.params[:id] = user.id
        controller.params[:user] = { email: 'test@email.com' }
        allow(controller).to receive(:action_name).and_return('update')
        expect(controller.send(:resource)).to eq(user)
      end
    end
  end

  context 'path helpers' do
    before do
      allow(controller).to receive(:resource).and_return(user)
    end

    %i[resource_path after_create_path after_update_path].each do |helper|
      describe "##{helper}" do
        it 'returns the current resource\'s "show" path' do
          expect(controller.send(helper)).to eq([user])
        end

        it 'returns the current resource\'s path with added base' do
          allow(controller).to receive(:resource_base_path).and_return([:admin])
          expect(controller.send(helper)).to eq([:admin, user])
        end
      end
    end

    %i[resources_path after_destroy_path].each do |helper|
      describe "##{helper}" do
        it 'returns the current resource\'s "index" path' do
          expect(controller.send(helper)).to eq(['users'])
        end

        it 'returns the current resource\'s path with added base' do
          allow(controller).to receive(:resource_base_path).and_return([:admin])
          expect(controller.send(helper)).to eq([:admin, 'users'])
        end
      end
    end
  end
end
