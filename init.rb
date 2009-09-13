module ActiveRecord
  module Associations
    module ClassMethods
      alias :ar_has_one :has_one
      def has_one(association_id, options = {})
        ares_return_value = ar_has_one(association_id, options)
        self.unify_attachments(association_id) if options[:class_name] == "UnifiedUpload"
        ares_return_value
      end
      
      def has_unified_attachment(association_id, options = {})
        default_options = { 
          :as => :uploadable,
          :class_name => "UnifiedUpload",
          :foreign_key => "uploadable_id", 
          :conditions => {:flavor => "#{self.name}_#{association_id.to_s}"}          
        }

        # gotta dupe before we merge conditions
        options = options.dup.symbolize_keys
        
        if options[:conditions]
          options[:conditions] = options[:conditions].dup.symbolize_keys
          options[:conditions].reverse_merge!(default_options[:conditions])
        end        

        options.reverse_merge!(default_options)        
        has_one(association_id, options)
      end
      
      def has_many_unified_attachments(association_id, options = {})
        default_options = { 
          :as => :uploadable,
          :class_name => "UnifiedUpload",
          :foreign_key => "uploadable_id", 
          :conditions => {:flavor => "#{self.name}_#{association_id.to_s}"}          
        }

        # gotta dupe before we merge conditions
        options = options.dup.symbolize_keys
        
        if options[:conditions]
          options[:conditions] = options[:conditions].dup.symbolize_keys
          options[:conditions].reverse_merge!(default_options[:conditions])
        end        

        options.reverse_merge!(default_options)        
        has_many(association_id, options)
      end

    end
  end
end
