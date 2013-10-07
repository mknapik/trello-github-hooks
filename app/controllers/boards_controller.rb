class BoardsController < ApplicationController
  include ApplicationHelper
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:push]
  before_action :set_repositories_collection, only: [:new, :update, :edit, :create]
  skip_before_filter :authenticate_user!, only: [:push]

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.all.select { |board| can? :view, board }
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    access_denied! 'cannot.view.board', boards_path if cannot? :view, @board
  end

  # POST /push
  def push
    payload = Payload.new(params['payload'])

    repository = Repository.where(name: payload.repository_name).first

    response = {success: true, comments: Array.new, errors: Array.new}

    if repository.nil?
      response[:success] = false
      response[:errors] << "Repository '#{payload.repository_name}' does not exist!"
    else
      payload.commits.select { |commit| commit.has_refs? }.each do |commit|
        repository.boards.each do |board|
          trello = board.trello
          # for each repository's board get all cards and check if card for given cardId exist

          cards_response = HTTParty.get trello.cards(board.uid)[:url]

          if cards_response.success?
            cards_response.map { |card_data| Card.new(card_data) }.select { |card| card.has_short_id?(commit.short_id) }.each do |card|
              # place a comment on this card
              comment = trello.comment(card.id, commit.comment)

              posted = HTTParty.post comment[:url],
                                     :body => comment[:body].to_json,
                                     :headers => {'Content-Type' => 'application/json'}

              if posted.success?
                response[:comments] << posted.parsed_response
              else
                response[:success] = false
                response[:errors] << posted.parsed_response
              end
            end
          else
            response[:success] = false
            response[:errors] << cards.parsed_response
          end
        end
      end
    end

    response[:errors].uniq!

    respond_to do |format|
      format.json { render json: response, status: :created }
    end
  end

  # GET /boards/new
  def new
    access_denied! 'cannot.create.board', boards_path if cannot? :create, Board

    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
    access_denied! 'cannot.edit.board', boards_path if cannot? :edit, @board
  end

  # POST /boards
  # POST /boards.json
  def create
    access_denied! 'cannot.create.board', boards_path if cannot? :create, Board

    @board = Board.new(board_params)
    access_denied! 'cannot.edit.board', boards_path if cannot? :edit, @board

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
    access_denied! 'cannot.edit.board', boards_path if cannot? :edit, @board

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
    access_denied! 'cannot.delete.board', boards_path if cannot? :edit, @board

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

  def set_repositories_collection
    @repositories = Repository.all.select { |repo| can? :view, repo }
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

  def post_comment(card_id, message, options = {})
    comment_url = trello_url("cards/#{card_id}/actions/comments", key: options[:key], token: options[:token])

    HTTParty.post comment_url,
                  :body => {:text => message}.to_json,
                  :headers => {'Content-Type' => 'application/json'}
  end
end
