require 'spec_helper'

describe ProfessorsController do

  before do
    @id = "42"
    @generated_password = "RANDPASS"
  end

  let(:valid_attributes) { { "nusp" => "MyString", "email" => "professor@ime.usp.br", "password" => "12345678", "department_id" => 1, "confirmed_at" => Time.now } }
  let(:other_valid_attributes) { { "nusp" => "9999999", "email" => "prof@ime.usp.br", "password" => "12345678", "department_id" => 1, "confirmed_at" => Time.now } }


  context 'when signed in as admin' do
    login_admin

    describe '.new' do
      before :each do
        get :new
      end
      context 'response' do
        subject { response }
        it { expect(subject).to render_template(:new) }
      end
      context 'user' do
        subject { assigns(:user) }
        it { expect(subject).to be_a_new(User) }
      end
      context 'professor' do
        subject { assigns(:professor) }
        it { expect(subject).to be_a_new(Professor) }
      end
    end

    describe '.create' do
      context 'with invalid params' do
        let(:params) { { user: { name: 'teste' }, professor: { department_id: 1 } } }
        before :each do
          post :create, params
        end
        subject { response }
        it { expect(subject).to render_template :new }
      end

      context 'succeeds to save' do
        let(:params) { {
          user: FactoryGirl.attributes_for(:user),
          professor: FactoryGirl.attributes_for(:professor)
        } }
        before :each do
          post :create, params
        end
        subject { response }
        it { expect(subject).to redirect_to assigns(:user) }
      end
    end

    describe '.index' do
      before :each do
        get :index
      end
      subject { response }
      it { expect(subject).to render_template :index }
    end

  end

  context 'when signed in as professor' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:professor) { FactoryGirl.create(:professor, user_id: user.id) }
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in :user, user
    end

    describe '.index' do
      before :each do
        get :index, {}
      end
      subject { response }
      it { expect(subject).to render_template :index }
    end

    describe ".edit" do
      before :each do
        get :edit, { :id => professor.id }
      end
      subject { assigns(:professor) }
      it { expect(subject).to eq(professor) }
    end

    describe ".update" do
      context "with valid params" do
        before :each do
          put :update, { id: professor.id, professor: { department_id: 2 } }
        end

        it { should respond_with :redirect }

        context 'professor' do
          subject { assigns(:professor) }
          it { expect(subject).to eq professor }
          its(:department_id) { should be 2 }
        end
      end

      context "with invalid params" do
        before :each do
          put :update, { id: professor.id, professor: { professor_ran: 1 } }
        end

        context 'professor' do
          subject { assigns(:professor) }
          it { expect(subject).to eq professor }
        end
      end
    end


  end
end
