class Fund < ApplicationRecord
    has_many :cash_transactions
    has_many :security_transactions
end
