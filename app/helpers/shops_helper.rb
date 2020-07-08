module ShopsHelper

  def merge_button
      link_to(t(:merge), '#' , class: 'btn btn-success btn-lg active', role: 'button', onclick: "window.peseidon.mergeResource('#{merge_shops_path}')")
  end

end
