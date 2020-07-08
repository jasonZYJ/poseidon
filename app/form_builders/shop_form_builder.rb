class ShopFormBuilder < FormBuilder

  def type
    association :type, :collection => ShopType.all.order(:name), :include_blank => false
  end

  def category
    input :category, collection: Category.all.order(:name), \
          input_html: {:onchange => "window.peseidon.selection_within_scope('#shop_category','#shop_sub_category_id','#{template.sub_categories_path}');"}
  end

  def sub_category
    association :sub_category, :collection => [], :include_blank => false
  end
  

end
