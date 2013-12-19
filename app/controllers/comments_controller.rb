class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_parking

  authorize_actions_for Comment, except: [:new, :create]

  # GET parkings/:parking_id/comments/new
  def new
    @comment = Comment.new

    unless current_user.can_create?(@comment, :for => @parking)
      raise Authority::SecurityViolation.new(current_user, :comment, @parking)
    end
  end

  # POST parkings/:parking_id/comments
  def create
    @comment = @parking.comments.build(commenter: current_user, comment: comment_params[:comment])

    unless current_user.can_create?(@comment, :for => @parking)
      raise Authority::SecurityViolation.new(current_user, :comment, @parking)
    end

    if @comment.save
      redirect_to parking_path(@parking), notice: 'Comment was successfully created.'
    else
      render action: :new
    end
  end


  private

  def set_parking
    @parking = Parking.find(params.require(:parking_id))
    authorize_action_for(@parking)
  end

  def comment_params
    params.require(:comment)
  end
end
