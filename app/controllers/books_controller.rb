class BooksController < ApplicationController

  def index
    @books = Book.all
    @book = Book.new
  end


  def create
    @book = Current.user.books.build(book_params)

    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index, status: :unprocessable_entity
    end
  end


  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end


  def edit
    @book = Book.find(params[:id])
  
    unless @book.user == Current.user
      redirect_to books_path
    end
  end


  def update
    @book = Book.find(params[:id])
  
    unless @book.user == Current.user
      redirect_to books_path
      return
    end
  
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @book = Book.find(params[:id])
  
    unless @book.user == Current.user
      redirect_to books_path
      return
    end
  
    @book.destroy
    redirect_to books_path, notice: "You have deleted book successfully."
  end

  private

  def book_params
    params.require(:book).permit(
      :title,
      :body
    )
  end

end