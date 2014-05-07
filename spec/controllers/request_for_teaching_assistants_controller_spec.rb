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

describe RequestForTeachingAssistantsController do

  include Devise::TestHelpers

  # This should return the minimal set of attributes required to create a valid
  # RequestForTeachingAssistant. As you add validations to RequestForTeachingAssistant, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {
    "professor_id" => "1",
    "subject" => "MAC0122semespaço",
    "requestedNumber" => 1,
    "priority" => 0,
    "student_assistance" => true,
    "work_correction" => false,
    "test_oversight" => true
  } }

  let(:not_owned_attributes) { {
    "professor_id" => "2",
    "subject" => "MAC0424",
    "requestedNumber" => 2,
    "priority" => 2,
    "student_assistance" => true,
    "work_correction" => false,
    "test_oversight" => false
  } }

  let(:valid_professor) { {
    "id" => 1,
    "password" => "prof-123",
    "email" => "prof@ime.usp.br"
  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RequestForTeachingAssistantsController. Be sure to keep this updated too.
  let(:valid_session) { { } }

  before :each do
    professor = Professor.create! valid_professor
    sign_in :professor, professor
  end

  describe "GET index" do
    it "assigns all request_for_teaching_assistants as @request_for_teaching_assistants" do
      request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
      get :index, {}
      assigns(:request_for_teaching_assistants).should eq([request_for_teaching_assistant])
    end
  end

  describe "GET show" do
    it "assigns the requested request_for_teaching_assistant as @request_for_teaching_assistant" do
      request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
      get :show, {:id => request_for_teaching_assistant.to_param}
      assigns(:request_for_teaching_assistant).should eq(request_for_teaching_assistant)
    end
  end

  describe "GET new" do
    it "assigns a new request_for_teaching_assistant as @request_for_teaching_assistant" do
      get :new, {}
      assigns(:request_for_teaching_assistant).should be_a_new(RequestForTeachingAssistant)
    end
  end

  describe "GET edit" do
    describe "a request from the signed professor" do
      it "assigns the requested request_for_teaching_assistant as @request_for_teaching_assistant" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        get :edit, {:id => request_for_teaching_assistant.to_param}
        assigns(:request_for_teaching_assistant).should eq(request_for_teaching_assistant)
      end
    end

    describe "edit a request not from the signed professor" do
      it "redirects back to the request list" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! not_owned_attributes
        get :edit, {:id => request_for_teaching_assistant.to_param}
        response.should redirect_to request_for_teaching_assistants_path
      end
    end
  end

  describe "POST create" do

    it "uses the current signed professor's id" do
      post :create, {:request_for_teaching_assistant => valid_attributes}, valid_session
      assigns(:request_for_teaching_assistant).professor_id.should be(valid_professor["id"])
    end

    describe "with valid params" do
      it "creates a new RequestForTeachingAssistant" do
        count_before = RequestForTeachingAssistant.count
        assert(!RequestForTeachingAssistant.exists?(valid_attributes[:id]))
        post :create, {:request_for_teaching_assistant => valid_attributes}
        count_after = RequestForTeachingAssistant.count
        (count_before+1).should equal(count_after)
      end

      it "assigns a newly created request_for_teaching_assistant as @request_for_teaching_assistant" do
        post :create, {:request_for_teaching_assistant => valid_attributes}
        assigns(:request_for_teaching_assistant).should be_a(RequestForTeachingAssistant)
        assigns(:request_for_teaching_assistant).should be_persisted
      end

      it "redirects to the created request_for_teaching_assistant" do
        post :create, {:request_for_teaching_assistant => valid_attributes}
        response.should redirect_to(RequestForTeachingAssistant.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved request_for_teaching_assistant as @request_for_teaching_assistant" do
        # Trigger the behavior that occurs when invalid params are submitted
        RequestForTeachingAssistant.any_instance.stub(:save).and_return(false)
        post :create, {:request_for_teaching_assistant => {}}
        assigns(:request_for_teaching_assistant).should be_a_new(RequestForTeachingAssistant)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        RequestForTeachingAssistant.any_instance.stub(:save).and_return(false)
        post :create, {:request_for_teaching_assistant => { "professor_id" => "invalid value" }}
        response.should render_template :new
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested request_for_teaching_assistant" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        # Assuming there are no other request_for_teaching_assistants in the database, this
        # specifies that the RequestForTeachingAssistant created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        RequestForTeachingAssistant.any_instance.should_receive(:update).with({ "professor_id" => "1" })
        put :update, {:id => request_for_teaching_assistant.to_param, :request_for_teaching_assistant => { "professor_id" => "1" }}
      end

      it "assigns the requested request_for_teaching_assistant as @request_for_teaching_assistant" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        put :update, {:id => request_for_teaching_assistant.to_param, :request_for_teaching_assistant => valid_attributes}
        assigns(:request_for_teaching_assistant).should eq(request_for_teaching_assistant)
      end

      it "redirects to the request_for_teaching_assistant" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        put :update, {:id => request_for_teaching_assistant.to_param, :request_for_teaching_assistant => valid_attributes}
        response.should redirect_to(request_for_teaching_assistant)
      end
    end

    describe "with invalid params" do
      it "assigns the request_for_teaching_assistant as @request_for_teaching_assistant" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RequestForTeachingAssistant.any_instance.stub(:save).and_return(false)
        put :update, {:id => request_for_teaching_assistant.to_param, :request_for_teaching_assistant => { "professor_id" => "invalid value" }}
        assigns(:request_for_teaching_assistant).should eq(request_for_teaching_assistant)
      end

      it "re-renders the 'edit' template" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        RequestForTeachingAssistant.any_instance.stub(:save).and_return(false)
        put :update, {:id => request_for_teaching_assistant.to_param, :request_for_teaching_assistant => { "professor_id" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do

    describe "a request from the signed professor" do
      it "destroys the requested request_for_teaching_assistant" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        expect {
          delete :destroy, {:id => request_for_teaching_assistant.to_param}
        }.to change(RequestForTeachingAssistant, :count).by(-1)
      end

      it "redirects to the request_for_teaching_assistants list" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! valid_attributes
        delete :destroy, {:id => request_for_teaching_assistant.to_param}
        response.should redirect_to(request_for_teaching_assistants_url)
      end
    end

    describe "a request not from the signed professor" do
      it "redirects back to the request list" do
        request_for_teaching_assistant = RequestForTeachingAssistant.create! not_owned_attributes
        delete :destroy, {:id => request_for_teaching_assistant.to_param}
        response.should redirect_to request_for_teaching_assistants_path
      end
    end
  end

end
