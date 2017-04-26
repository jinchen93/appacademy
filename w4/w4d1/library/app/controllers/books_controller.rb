class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    # your code here
  end

  def create
    params.require
  end

  def create
  
  end

  def create
    # your code here
  end

  def destroy
    # your code here
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end
end
