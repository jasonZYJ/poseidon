module AgreementsHelper
include ResourceButtonsHelper

  def create_lease_button
    link_to '创建合同', new_agreement_lease_path(outer.id), method: :get, remote: true, class: 'btn btn-lg btn-warning'
  end
end
