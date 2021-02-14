class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activity = Activity.new
    @activities = Activity.where(user_id: current_user.id).order("date DESC").all
    @last_record = Activity.where(user_id: current_user.id).order("created_at").last
  end

  def create
    new_activity = Activity.new(activity_params)
    new_activity.user_id = current_user.id

    if new_activity.save
      flash.alert = I18n.t "saved_msg"
      redirect_to root_path
    else
      flash.alert = new_activity.errors.full_messages
      redirect_to root_path
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:weight, :date, :time, :distance)
  end
end
