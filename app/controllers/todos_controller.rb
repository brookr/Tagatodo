class TodosController < ApplicationController
  layout :set_layout
  
  # GET /todos
  # GET /todos.json
  def index
    if params[:completed]
      @todos = current_or_guest_user.todos.where(:completed => params[:completed])
    elsif params[:tags]
      @todos = current_or_guest_user.todos.tagged_with(params[:tags].split(','))
    else
      @todos = current_or_guest_user.todos
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])

    authorize! :manage, @todo

    respond_to do |format|
      format.html do
        if request.xhr?
          render 'show'
        else
          @todos = current_or_guest_user.todos
          
          render 'index'
        end
      end

      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])

    authorize! :manage, @todo
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = current_or_guest_user.todos.new(params[:todo])

    authorize! :manage, @todo

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
        format.json { render json: @todo, status: :created, location: @todo }
      else
        format.html { render action: "new" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])

    authorize! :manage, @todo

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo = Todo.find(params[:id])

    authorize! :manage, @todo

    @todo.destroy

    respond_to do |format|
      format.html { redirect_to todos_url }
      format.json { head :no_content }
    end
  end

  private

  def set_layout
    if request.headers['X-PJAX']
      false
    else
      'application'
    end
  end
end
