class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @book = Book.new
    @books = Book.all
    #@user_info = User.find(current_user.id)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
     # @user_info = User.find(current_user.id)
      render :index
      #@post = book.new
    end
  end

  def show
    #@user_info = @book.user
    @book = Book.find(params[:id])
    @post = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    #unless @book.user == current_user
     # redirect_to books_path
   # end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:update_book] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    #unless book.user == current_user
    #redirect_to books_path
    #end
    @book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
    redirect_to books_path
    end
  end
end