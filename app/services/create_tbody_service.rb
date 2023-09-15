class CreateTbodyService
  include ActionView::Helpers::AssetTagHelper
  def initialize; end

  def create_body(annual_investments)
    tbody = ''
    annual_investments.each do |investment|
      tbody << create_row(investment)
    end

    tbody
  end

  def create_row(investment)
    " <tr>
        <th scope='row'>
          <p class='fs-2'>
            <img class='icon' src='assets/#{investment[:currency].downcase}.png'>
            #{investment[:name]}
            <span class='abbreviation'> #{investment[:currency]} </span>
          </p>
        </th>
        <td> #{investment[:price]}  </td>
        <td> #{investment[:monthly_interest]}</td>
        <td> #{investment[:annual_investment]}  </td>
      </tr>
    "
  end
end
