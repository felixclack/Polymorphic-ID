module HasPolymorphicId
  
  def has_polymorphic_id(*fields)
    fields.each do |field|
      @association = "#{field}_polymorphic_id".to_sym
      
      class_eval do
        attr_reader @association
        attr_accessible @association

        define_method "#{@association}=" do |value|
          return if value.blank?
          value.chomp!(",")
          if is_polymorphic? value
            polymorphic_class, polymorphic_id = value.split("_").flatten
            send("#{field}=", polymorphic_class.constantize.find(polymorphic_id.to_i))
          else
            send("#{field}=", polymorphic_class.classify.constantize.create(:name => value)
          end
        end
        
        def is_polymorphic?(this_id)
          !this_id.scan(/^(\D+)_(\d+)$/).flatten.empty?
        end
        
      end
    end
  end
  
end

ActiveRecord::Base.send(:extend, HasPolymorphicId)