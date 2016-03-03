class DashboardController < ApplicationController

  def index
    @user_info = current_user
    @resorts   = current_user.resorts
    @states    = state_list
  end

  private

  def trailapi_service
    TrailapiService.new
  end

  def state_list
    state_abbr = {
        'AK' => 'Alaska', 'AZ' => 'Arizona',
        'CA' => 'California', 'CO' => 'Colorado',
        'CT' => 'Connecticut', 'DE' => 'Delaware',
        'DC' => 'District of Columbia', 'ID' => 'Idaho',
        'IL' => 'Illinois', 'IN' => 'Indiana',
        'IA' => 'Iowa', 'KS' => 'Kansas',
        'KY' => 'Kentucky', 'ME' => 'Maine',
        'MD' => 'Maryland', 'MA' => 'Massachusetts',
        'MI' => 'Michigan', 'MN' => 'Minnesota',
        'MT' => 'Montana', 'NE' => 'Nebraska',
        'NV' => 'Nevada', 'NH' => 'New Hampshire',
        'NJ' => 'New Jersey', 'NM' => 'New Mexico',
        'NY' => 'New York', 'NC' => 'North Carolina',
        'ND' => 'North Dakota', 'OH' => 'Ohio',
        'OR' => 'Oregon', 'PA' => 'Pennsylvania',
        'RI' => 'Rhode Island', 'SD' => 'South Dakota',
        'TN' => 'Tennessee', 'TX' => 'Texas',
        'UT' => 'Utah', 'VT' => 'Vermont',
        'VA' => 'Virginia', 'WA' => 'Washington',
        'WV' => 'West Virginia', 'WI' => 'Wisconsin',
        'WY' => 'Wyoming'
    }
  end

end
