require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  it 'successfully connects' do
    expect { connect '/cable' }.not_to have_rejected_connection
  end
end
