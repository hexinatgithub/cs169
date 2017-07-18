require 'spec_helper'

describe Admin::CategoriesController do
  render_views

  before(:each) do
    Factory(:blog)
    #TODO Delete after removing fixtures
    Profile.delete_all
    henri = Factory(:user, :login => 'henri', :profile => Factory(:profile_admin, :label => Profile::ADMIN))
    request.session = { :user => henri.id }
  end

  def compare_categorites_with_attributes(category, attributes)
    expect(category.name).to eq attributes[:name]
    expect(category.keywords).to eq attributes[:keywords]
    expect(category.permalink).to eq attributes[:permalink]
    expect(category.description).to eq attributes[:description]
  end

  it "test_index" do
    get :index
    assert_response :redirect, :action => 'index'
  end

  describe "test_edit" do
    before(:each) do
      get :edit, :id => Factory(:category).id
    end

    it 'should render template new' do
      assert_template 'new'
      assert_tag :tag => "table",
        :attributes => { :id => "category_container" }
    end

    it 'should have valid category' do
      assigns(:category).should_not be_nil
      assert assigns(:category).valid?
      assigns(:categories).should_not be_nil
    end
    
    it 'should change category' do
      category = Category.create(:name => "test1", :keywords => "testKey1", :permalink => "general1", :description => "test1Body")
      changed_attributes = {:name => "test2", :keywords => "testKey2", :permalink => "general2", :description => "test2Body"}
      post :edit, :id => category.id, :category => changed_attributes
      category = Category.find(category.id)
      compare_categorites_with_attributes(category, changed_attributes)
    end
  end
  
  describe "test_new" do
    it 'should create a new category' do
      attributes = {:name => "test2", :keywords => "testKey2", :permalink => "general2", :description => "test2Body"}
      post :new, :category => attributes
      category = Category.find_by_name "test2"
      expect(category).not_to be_nil
      compare_categorites_with_attributes(category, attributes)
    end
  end

  it "test_update" do
    post :edit, :id => Factory(:category).id
    assert_response :redirect, :action => 'index'
  end

  describe "test_destroy with GET" do
    before(:each) do
      test_id = Factory(:category).id
      assert_not_nil Category.find(test_id)
      get :destroy, :id => test_id
    end

    it 'should render destroy template' do
      assert_response :success
      assert_template 'destroy'      
    end
  end

  it "test_destroy with POST" do
    test_id = Factory(:category).id
    assert_not_nil Category.find(test_id)
    get :destroy, :id => test_id

    post :destroy, :id => test_id
    assert_response :redirect, :action => 'index'

    assert_raise(ActiveRecord::RecordNotFound) { Category.find(test_id) }
  end
  
end
