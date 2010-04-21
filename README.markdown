Polymorphic-id
==============

Rails plugin to make life a bit simpler when dealing with polymorphic objects in your forms.

Install
=======

    script/plugin install git://github.com/kid80/Polymorphic-ID.git
    
Usage
=======

Say you have a model called Payment that has a polymorphic payee:

    class Payment < ActiveRecord::Base
      belongs_to :payee, :polymorphic => true
    end

add a `has_polymorphic_id`

    class Payment < ActiveRecord::Base
      belongs_to :payee, :polymorphic => true
      
      has_polymorphic_id :payee
    end
    
then in your view

    <% form_for @payment do |form| %>
      <%= f.label :payee_polymorphic_id, "Payee" %>
      <%= f.collection_select :payee_polymorphic_id, Payee.all, :id, :name %>
    <% end %>

Copyright (c) 2010 Felix Clack, released under the MIT license