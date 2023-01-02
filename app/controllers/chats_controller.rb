class ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      # 自分と相手の中間テーブルを作成
      UserRoom.create(user_id: current_user.id, room_id: @room.id) #create()はnewとsaveを同時にできる
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    # @chat = Chat.new(chat_params)
    # chat.user_id = current_user.idの略
    render :validater unless @chat.save #新規投稿が保存されなかった場合validater.js.erbを探す。保存された場合はcreate.js.erbを探す
  end


  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to posts_path
    end
  end

end
