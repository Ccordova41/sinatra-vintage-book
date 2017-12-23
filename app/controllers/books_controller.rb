class BooksController < ApplicationController

  # GET: /books
  get "/books" do
    if logged_in?
      @books = Book.all
      erb :"/books/index.html"
    else
      redirect to "/login"
    end
  end

  # GET: /books/new
  get "/books/new" do
    if logged_in?
      erb :"/books/new.html"
    else
      redirect to "/login"
    end
  end

  # POST: /books
  post "/books" do
    if params[:title] == "" || params[:author] == ""
      redirect "/books/new"
    else
      book = Book.new(params)
      book.user_id = session[:user_id]
      book.save
      redirect to "/books"
    end
  end

  # GET: /books/5
  get "/books/:slug" do
    @book = Book.find_by_slug(params[:slug])
    erb :"/books/show.html"
  end

  # GET: /books/5/edit
  get "/books/:id/edit" do
    erb :"/books/edit.html"
  end

  # PATCH: /books/5
  patch "/books/:id" do
    redirect "/books/:id"
  end

  # DELETE: /books/5/delete
  delete "/books/:id/delete" do
    redirect "/books"
  end
end
