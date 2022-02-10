class SecurityTransaction < ApplicationRecord
  belongs_to :fund
  belongs_to :security
end
