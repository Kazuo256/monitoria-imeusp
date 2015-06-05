require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe AssistantEvaluationsController do

  include Devise::TestHelpers

  let(:prof_user) { FactoryGirl.create :another_user }
  let!(:super_professor) { FactoryGirl.create :super_professor, user_id: prof_user.id }

  before :each do
    @semester   = FactoryGirl.create :semester
    @department = FactoryGirl.create :department
    @course1    = FactoryGirl.create :course1
    @student    = FactoryGirl.create :student
    @request_for_teaching_assistant = FactoryGirl.create :request_for_teaching_assistant, professor_id: super_professor.id
    @assistant_role = FactoryGirl.create :assistant_role
    sign_in prof_user
  end

  describe "GET index" do
    before :each do
      @assistant_evaluation = FactoryGirl.create :assistant_evaluation
      it{ expect(Student).to receive(:find).with(@student.id.to_s).and_return(@student) }
      get :index_for_student, { student_id: @student.id }
    end

    it { expect(response).to be_ok }

    it "assigns the student as @student" do
      it { expect(assigns(:student)).to eq(@student) }
    end

    it "assigns all assistant_evaluations for the student as @assistant_evaluations" do
      it { expect(assigns(:assistant_evaluations)).to eq([@assistant_evaluation]) }
    end
  end

  describe ".new" do
    before :each do
      get :new, { assistant_role_id: @assistant_role.id }
    end
    context 'assistant evaluation' do
      subject { assigns(:assistant_evaluation) }
      it { expect(subject).to be_a_new(AssistantEvaluation) }
      it { expect(:assistant_role_id).to eq(@assistant_role.id) }
    end
  end

  describe "GET edit" do
    it "assigns the requested assistant_evaluation as @assistant_evaluation" do
      assistant_evaluation = FactoryGirl.create :assistant_evaluation
      it { expect(AssistantEvaluation).to receive(:find).with(assistant_evaluation.id.to_s).and_return(assistant_evaluation) }
      get :edit, { id: assistant_evaluation.to_param }
      it { expect(assigns(:assistant_evaluation)).to eq(assistant_evaluation) }
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before :each do
        @params = {
          "assistant_role_id" => "1",
          "ease_of_contact" => "1",
          "efficiency" => "1",
          "reliability" => "1",
          "overall" => "1",
          "comment" => "MyText"
        }
        @assistant_evaluation = FactoryGirl.create :assistant_evaluation
        it { expect(@assistant_evaluation).to receive(:save).and_return(true) }
        it { expect(AssistantEvaluation).to receive(:new).with(@params).and_return(@assistant_evaluation) }
        post :create, { assistant_evaluation: @params }
      end

      it "assigns a newly created assistant_evaluation as @assistant_evaluation and persists it" do
        it { expect(assigns(:assistant_evaluation)).to be_a(AssistantEvaluation) }
        it { expect(assigns(:assistant_evaluation)).to be_persisted }
      end

      it "redirects to the created assistant_evaluation" do
        # TODO should use @super_professor, but for some reason that does not work
        it { expect(response).to redirect_to(assistant_roles_for_professor_path(professor_id: super_professor.id)) }
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved assistant_evaluation as @assistant_evaluation" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(AssistantEvaluation).to receive(:save).and_return(false)
        post :create, {:assistant_evaluation => { "index_for_student" => "invalid value" }}
        it { expect(assigns(:assistant_evaluation)).to be_a_new(AssistantEvaluation) }
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(AssistantEvaluation).to receive(:save).and_return(false)
        post :create, {:assistant_evaluation => { "index_for_student" => "invalid value" }}
        it { expect(response).to render_template("new") }
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before :each do
        @params = {
          "assistant_role_id" => "1",
          "ease_of_contact" => "1",
          "efficiency" => "1",
          "reliability" => "1",
          "overall" => "1",
          "comment" => "MyText"
        }
      end

      it "updates the requested assistant_evaluation" do
        assistant_evaluation = FactoryGirl.create :assistant_evaluation
        # Assuming there are no other assistant_evaluations in the database, this
        # specifies that the AssistantEvaluation created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        it { expect(AssistantEvaluation.any_instance).to receive(:update).with(@params) }
        put :update, {:id => assistant_evaluation.to_param, :assistant_evaluation => @params}
      end

      it "assigns the requested assistant_evaluation as @assistant_evaluation" do
        assistant_evaluation = FactoryGirl.create :assistant_evaluation
        put :update, {:id => assistant_evaluation.to_param, :assistant_evaluation => @params}
        it { expect(assigns(:assistant_evaluation)).to eq(assistant_evaluation) }
      end

      it "redirects to the assistant_evaluation" do
        assistant_evaluation = FactoryGirl.create :assistant_evaluation
        put :update, {:id => assistant_evaluation.to_param, :assistant_evaluation => @params}
        # TODO should use @super_professor, but for some reason that does not work
        it { expect(response).to redirect_to(assistant_roles_for_professor_path(professor_id: super_professor.id)) }
      end
    end

    describe "with invalid params" do
      it "assigns the assistant_evaluation as @assistant_evaluation" do
        assistant_evaluation = FactoryGirl.create :assistant_evaluation
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(AssistantEvaluation).to receive(:save).and_return(false)
        put :update, {:id => assistant_evaluation.to_param, :assistant_evaluation => { "index_for_student" => "invalid value" }}
        it { expect(assigns(:assistant_evaluation)).to eq(assistant_evaluation) }
      end

      it "re-renders the 'edit' template" do
        assistant_evaluation = FactoryGirl.create :assistant_evaluation
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(AssistantEvaluation).to receive(:save).and_return(false)
        put :update, {:id => assistant_evaluation.to_param, :assistant_evaluation => { "index_for_student" => "invalid value" }}
        it { expect(response).to render_template("edit") }
      end
    end
  end
end
