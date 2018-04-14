class InformationController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  def index
    @results= [ ]
    @highschool = params[:highschool]
    @university = params[:university]
    @faculty = params[:faculty]
    @content = params[:content]
    if @highschool != "" and @university == "" and @faculty == "" and @content == ""
      @results = Information.highschool_search(highschool: @highschool)
    elsif @highschool != "" and @university != "" and @faculty == "" and @content == ""
      @results = Information.highschool_university_search(highschool: @highschool, university: @university)
    elsif @highschool != "" and @university == "" and @faculty != "" and @content == ""
      @results = Information.highschool_faculty_search(highschool: @highschool, faculty: @faculty)
    elsif @highschool != "" and @university == "" and @faculty == "" and @content != ""
      @results = Information.highschool_content_search(highschool: @highschool, content: @content)
    elsif @highschool != "" and @university != "" and @faculty != "" and @content == ""
      @results = Information.highschool_university_faculty_search(highschool: @highschool, university: @university, faculty: @faculty)
    elsif @highschool != "" and @university == "" and @faculty != "" and @content == ""
      @results = Information.highschool_faculty_content_search(highschool: @highschool, faculty: @faculty, content: @content)
    elsif @highschool == "" and @university != "" and @faculty != "" and @content != ""
      @results = Information.university_faculty_content_search(university: @university, faculty: @faculty, content: @content)
    elsif @highschool != "" and @university != "" and @faculty == "" and @content != ""
      @results = Information.highschool_university_content_search(highschool: @highschool, university: @university, content: @content)
    elsif @highschool == "" and @university != "" and @faculty == "" and @content == ""
      @results = Information.university_search(university: @university)
    elsif @highschool == "" and @university != "" and @faculty != "" and @content == ""
      @results = Information.university_faculty_search(university: @university, faculty: @faculty)
    elsif @highschool == "" and @university != "" and @faculty == "" and @content != ""
      @results = Information.university_content_search(university: @university, content: @content)
    elsif @highschool == "" and @university == "" and @faculty != "" and @content == ""
      @results = Information.faculty_search(faculty: @faculty)
    elsif @highschool == "" and @university == "" and @faculty != "" and @content != ""
      @results = Information.faculty_content_search(faculty: @faculty, content: @content)
    elsif @highschool == "" and @university == "" and @faculty == "" and @content != ""
      @results = Information.content_search(content: @content)
    end
  end

  def new
    if logged_in?
      if current_user.information
        redirect_to current_user
      else
        @user = current_user
        @information = current_user.build_information
      end
    end
  end

  def create
    @information = current_user.build_information(information_params)
    if @information.save
      flash[:success] = '投稿に成功しました'
      redirect_to current_user
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  def destroy
    @information.destroy
    flash[:success] = '削除に成功しました'
    redirect_to root_url
  end
  
  private
  
  def information_params
    params.require(:information).permit(:highschool, :university, :faculty, :content)
  end
  
  def correct_user
    @information = current_user.information
    unless @information
      redirect_to root_url
    end
  end
end
