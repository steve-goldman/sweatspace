module ApplicationHelper
  def modal_dialog
    content_tag :div, "",
                id: "modal-new-element",
                class: "modal fade",
                style: "display: none;",
                tabindex: "-1"
  end
end
