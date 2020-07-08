module Stateful
  extend ActiveSupport::Concern

  included do
    resource_class.states.each do |action|
      module_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
          def #{action}
            memoize_collection { collection.#{action} }
            render_index
          end
      RUBY_EVAL
    end

    def render_index
      respond_with do |format|
        format.any(:html, :json) { render :index }
      end
    end
  end

end
