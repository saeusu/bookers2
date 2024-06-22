class BooksController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @book = Book.new
    @book.title = ""
    @book.body = ""
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:notice] = "You have created book successfully."
      @book.title = ""
      @book.body = ""
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      flash.now[:error] = @error_messages
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      @book.title = ""
      @book.body = ""
      redirect_to book_path(@book.id)
    else
      @error_messages = @book.errors.full_messages
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

end
