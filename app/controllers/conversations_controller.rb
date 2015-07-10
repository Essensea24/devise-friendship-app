class ConversationsController < ApplicationController
	before_filter :authenticate_user!
	#To prevent the show view inheriting from application.html layout
	layout false
 	#When a user clicks the button, we will send an asynchronous request to our rails app with the current user's id and the recipient id. If a conversation exists, we return the conversation id immediately, otherwise we create the conversation and return the id of the newly created conversation.
	def create
		#if a conversation exists between the sender_id and recipient_id, return it and assign it to the @conversation instance variable
		if Conversation.between(params[:sender_id],params[:recipient_id]).present?
		@conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
		else
		#If no conversation was found between the two users, create a new conversation and return a json response with the id of the conversation.
		@conversation = Conversation.create!(conversation_params)
		end

		render json: { conversation_id: @conversation.id }
	end

	def show
		@conversation = Conversation.find(params[:id])
		@reciever = interlocutor(@conversation)
		@messages = @conversation.messages
		@message = Message.new
	end

	private

	def conversation_params
		params.permit(:sender_id, :recipient_id)
	end

	def interlocutor(conversation)
		current_user == conversation.recipient ? conversation.sender : conversation.recipient
	end

end
