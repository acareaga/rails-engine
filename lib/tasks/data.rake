require 'csv'

namespace :data do
  task :import => :environment do

    CSV.foreach('data/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
      puts "Created merchant #{row.to_h["name"]}"
    end

    CSV.foreach('data/items.csv', headers: true) do |row|
      Item.create(row.to_h)
      puts "Created #{row.to_h["name"]}"
    end

    CSV.foreach('data/customers.csv', headers: true) do |row|
      Customer.create(row.to_h)
      puts "Created customer #{row.to_h["first_name"]} #{row.to_h["last_name"]}"
    end

    CSV.foreach('data/invoices.csv', headers: true) do |row|
      Invoice.create(row.to_h)
      puts "Created invoice #{row.to_h["id"]}"
    end

    CSV.foreach('data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create(row.to_h)
      puts "Created invoice item #{row.to_h["id"]}"
    end

    CSV.foreach('data/transactions.csv', headers: true) do |row|
      Transaction.create({  invoice_id: row["invoice_id"],
                            credit_card_number: row["credit_card_number"],
                            result: row["result"],
                            created_at: row["created_at"],
                            updated_at: row["updated_at"]
                        })
      puts "Imported transaction #{row.to_h["id"]}"
    end
  end
end
