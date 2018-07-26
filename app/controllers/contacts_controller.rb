class ContactsController < ApplicationController
  before_action :access_admin, only: [:index]
  def new
    @contact = Contact.new
  end
  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.save
      redirect_to root_path
    end
  end
  def index
    @contacts = Contact.all
  end
  private
    def contact_params
      params.require(:contact).permit(:comment, :user_id)
    end
    def access_admin
         unless   admin_signed_in?
           redirect_to root_path
         end
     end
end
