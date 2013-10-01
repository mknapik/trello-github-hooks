class BoardsController < ApplicationController
  include ApplicationHelper
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:push]

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.all
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
  end

  # POST /push
  def push
    full_name = "#{repository_params['owner']['name']}/#{repository_params['name']}"
    commits = commits_params['commits']
    repository = Repository.where(name: full_name).first

    commented_on = {:success => true, :comments => Array.new, :errors => Array.new}

    if repository.nil?
      commented_on[:success] = false
      commented_on[:errors] = "Repository '#{full_name}' does not exist!"
    else
      commits.each do |commit|
        message = "#{commit['author']['username']}: #{commit['message']} [#{commit['id']}](#{commit['url']})"
        match = commit['message'].match(/\#(?<cardId>\d+)/)
        unless match.nil?
          cardId = match[:cardId]

          repository.boards.each do |board|
            cards_url = trello_url("boards/#{board.uid}/cards", key: board.key, token: board.token)
            cards = HTTParty.get cards_url

            if cards.success?
              cards.each do |card|
                if card['idShort'].to_s == cardId
                  comment_url = trello_url("cards/#{card['id']}/actions/comments", key: board.key, token: board.token)

                  response = HTTParty.post comment_url,
                                           :body => {:text => message}.to_json,
                                           :headers => {'Content-Type' => 'application/json'}
                  if response.success?
                    commented_on[:comments] << response.parsed_response
                  else
                    commented_on[:success] = false
                    commented_on[:errors] = response.parsed_response
                  end
                end
              end
            else
              commented_on[:success] = false
              commented_on[:errors] << cards.parsed_response
            end
          end
        end
      end
    end

    commented_on[:errors].uniq!

    respond_to do |format|
      format.json { render json: commented_on, status: :created }
    end
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: 'Board was successfully created.' }
        format.json { render action: 'show', status: :created, location: @board }
      else
        format.html { render action: 'new' }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1
  # PATCH/PUT /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_board
    @board = Board.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def board_params
    params.require(:board).permit(:uid, :name, :repository_id)
  end

  def repository_params
    params.require(:repository).permit(:name, :owner => [:email, :name])
  end

  def commits_params
    params.permit(:commits => [:message, :id, :url, :author => [:email, :name, :username]])
  end
end
