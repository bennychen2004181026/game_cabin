class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # Helper module for identify two status of product model
  module Status
    Available = 'available'
    Not_available = 'not_available'
  end

  # Helper module for selecting different state in address
  module State
    ACT = 'ACT'
    NSW = 'NSW'
    NT = 'NT'
    QLD = 'QLD'
    SA = 'SA'
    TAS = 'TAS'
    VIC = 'VIC'
    WA = 'WA'
  end
end
