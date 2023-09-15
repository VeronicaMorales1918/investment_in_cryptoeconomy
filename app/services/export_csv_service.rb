require 'csv'

class ExportCsvService
  def self.generate_csv(annual_investments)
    CSV.generate do |csv|
      csv << ['Nombre', 'Precio', 'Interes mensual', 'Inversion anual']
      annual_investments.each do |investment|
        csv << [investment[:name], investment[:price], investment[:monthly_interest], investment[:annual_investment] ]
      end
    end
  end
end
