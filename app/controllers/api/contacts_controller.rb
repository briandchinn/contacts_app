class Api::ContactsController < ApplicationController
 
  before_action :authenticate_user

  def index
    @contacts = current_user.contacts

    if params[:first_name]
      @contacts = @contacts.where("first_name iLIKE ?", "#{params[:first_name]}")
    end

    if params[:search]
      @contacts = @contacts.where("first_name iLike ? OR middle_name iLike ? OR last_name iLike ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:group]
      group = Group.find_by(name: params[:group])
      @contacts = group.contacts.where(user_id: current_user.id)
    end

    render "index.json.jbuilder"

  end

  def create
    @contact = Contact.new(
                first_name: params[:first_name],
                middle_name: params[:middle_name],
                last_name: params[:last_name],
                email: params[:email],
                phone_number: params[:phone_number],
                bio: params[:bio],
                user_id: current_user.id
                )
    @contact.save

    if @contact.save
      render "show.json.jbuilder"
    else
      render json: {errors: @contact.errors.full_messages}, status: :unprocessable_entity
    end

  end

  def show
    @contact = Contact.find(params[:id])
    render "show.json.jbuilder"
  end

  

  def update
    @contact = Contact.find(params[:id])

    @contact.first_name = params[:first_name] || @contact.first_name
    @contact.middle_name = params[:middle_name] || @contact.middle_name
    @contact.last_name = params[:last_name] || @contact.last_name
    @contact.email = params[:email] || @contact.email
    @contact.phone_number = params[:phone_number] || @contact.phone_number
    @contact.bio = params[:bio] || @contact.bio

    @contact.save

    if @contact.save
      render "show.json.jbuilder"
    else
      render json: {errors: @contact.errors.full_messages}, status: :unprocessable_entity
    end  
    
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    render json: {message: "You destroyed product #{params[:id]}!"}
  end

end

