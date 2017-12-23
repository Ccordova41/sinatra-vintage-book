class BooksController < ApplicationController

  get "/books/new" do
    if logged_in?
      erb :"/books/new.html"
    else
      redirect to "/login"
    end
  end

  # POST: /books
  post "/books" do
    if params[:title] == ""
      redirect "/books/new"
    else
      @book = Book.new(params)
      @book.user_id = session[:user_id]
      @book.save
      redirect to "/books/#{@book.slug}"
    end
  end

  # GET: /books/5
  get "/users/:user_slug/books/:slug" do
    if logged_in?
      if @user = User.find_by_slug(params[:user_slug])
       if @book = @user.books.find_by_slug(params[:slug])
      erb :"/books/show.html"
    else
      redirect to "/books/new"
    end
  else
    redirect to "/signup"
  end
else
      redirect to "/login"
  end
end
  # GET: /books/5/edit
  get "/users/:user_slug/books/:slug/edit" do
    if logged_in?
      @user = current_user
      @book = current_user.books.find_by_slug(params[:slug])
      if @book.user_id == current_user.id
        erb :"books/edit.html"
      else
        redirect to "/books/#{@book.slug}"
      end
    else
      redirect to "/login"
    end
  end

  # PATCH: /books/5
  patch "/users/:user_slug/books/:slug" do
    @user = current_user
    @book = current_user.books.find_by_slug(params[:slug])
    if params[:title].empty?
      redirect to "/books/#{@book.slug}"/edit
    else
      @book.update(title: params[:title], author: params[:author], publisher: params[:publisher], genre: params[:genre], pages: params[:pages])
      redirect "/users/#{@user.slug}/books/#{@book.slug}"
    end
  end

  # DELETE: /books/5/delete
  delete "/users/:user_slug/books/:slug/delete" do
      if logged_in?
        @user = current_user
        @book = @user.books.find_by_slug(params[:slug])
        @book.delete
        redirect "/users/#{@user.slug}"
      else
        redirect to "/login"
      end
    end
  end
