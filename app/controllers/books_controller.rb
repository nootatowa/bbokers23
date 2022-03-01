class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new = Book.new
    @books = Book.all
    @book_comment = BookComment.new
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book.id),flash: { notice: 'Book was successfully created.' }
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  if @book.user == current_user
     render "edit"
  else
     redirect_to books_path
  end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body,)
  end
end
