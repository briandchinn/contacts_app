class Api::ContactsController < ApplicationController
    def contact_action
      @contact = Contact.first
      render "contacts.json.jbuilder"
    end


#Do this but create a new route and view

    def all_contacts_action
      @contacts = Contact.all
      render "all.contacts.json.jbuilder"
    end
end

