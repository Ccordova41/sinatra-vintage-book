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
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
      erb :"/books/show.html"
    else
      redirect to "/login"
  end

  # GET: /books/5/edit
  get "/books/:slug/edit" do
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
      if @book.user_id == current_user.id
        erb :"books/edit.html"
      else
        redirect to "/books"
      end
    else
      redirect to "/login"
    end
  end

  # PATCH: /books/5
  patch "/books/:slug" do
    @book = Book.find_by_slug(params[:slug])
    if params[:title].empty? || params[:author].empty?
      redirect to "/books/#{@book.slug}"/edit
    else
      @book.update(title: params[:title],author: params[:author],publisher: params[:publisher],genre: params[:genre],pages: params[:pages])
      redirect "/books/#{@book.slug}"
    end
  end

  # DELETE: /books/5/delete
  delete "/books/:id/delete" do
    redirect "/books"
  end
end
