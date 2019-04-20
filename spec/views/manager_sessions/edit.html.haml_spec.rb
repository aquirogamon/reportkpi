require 'rails_helper'

RSpec.describe "manager_sessions/edit", type: :view do
  before(:each) do
    @manager_session = assign(:manager_session, ManagerSession.create!(
      :ip_endpoint => "MyString",
      :name_endpoint => "MyString",
      :product_endpoint => "MyString",
      :state_endpoint => "MyString",
      :type_endpoint => "MyString",
      :capability => "MyString",
      :port_endpoint => "MyString",
      :tos_endpoint => "MyString",
      :name_session => "MyString",
      :sessionType => "MyString",
      :sid => 1.5,
      :dstEndpoint => "MyString",
      :dstPort => 1.5,
      :srcEndpoint => "MyString",
      :srcIfc => "MyString",
      :srcPort => 1.5,
      :state_session => "MyString",
      :interval_session => 1.5,
      :tos_session => 1.5,
      :payloadsize_session => 1.5,
      :pps_session => 1.5,
      :type_port => "MyString",
      :sla => "MyString",
      :status_device => "MyString",
      :ip_interface_vcx => "MyString",
      :dp50_p2r => 1.5,
      :dpmax_p2r => 1.5,
      :dpmin_p2r => 1.5,
      :lossPercent_p2r => 1.5,
      :dp50_r2p => 1.5,
      :dpmax_r2p => 1.5,
      :dpmin_r2p => 1.5,
      :lossPercent_r2p => 1.5,
      :delay_50 => 1.5,
      :delay_max => 1.5,
      :delay_min => 1.5,
      :lossPercent_p2r_p95 => 1.5,
      :lossPercent_r2p_p95 => 1.5,
      :delay_50_p95 => 1.5,
      :delay_max_p95 => 1.5,
      :events_delay50 => 1,
      :events_lossp2r => 1,
      :events_lossr2p => 1,
      :accediandevice => nil,
      :tx_provider => nil
    ))
  end

  it "renders the edit manager_session form" do
    render

    assert_select "form[action=?][method=?]", manager_session_path(@manager_session), "post" do

      assert_select "input[name=?]", "manager_session[ip_endpoint]"

      assert_select "input[name=?]", "manager_session[name_endpoint]"

      assert_select "input[name=?]", "manager_session[product_endpoint]"

      assert_select "input[name=?]", "manager_session[state_endpoint]"

      assert_select "input[name=?]", "manager_session[type_endpoint]"

      assert_select "input[name=?]", "manager_session[capability]"

      assert_select "input[name=?]", "manager_session[port_endpoint]"

      assert_select "input[name=?]", "manager_session[tos_endpoint]"

      assert_select "input[name=?]", "manager_session[name_session]"

      assert_select "input[name=?]", "manager_session[sessionType]"

      assert_select "input[name=?]", "manager_session[sid]"

      assert_select "input[name=?]", "manager_session[dstEndpoint]"

      assert_select "input[name=?]", "manager_session[dstPort]"

      assert_select "input[name=?]", "manager_session[srcEndpoint]"

      assert_select "input[name=?]", "manager_session[srcIfc]"

      assert_select "input[name=?]", "manager_session[srcPort]"

      assert_select "input[name=?]", "manager_session[state_session]"

      assert_select "input[name=?]", "manager_session[interval_session]"

      assert_select "input[name=?]", "manager_session[tos_session]"

      assert_select "input[name=?]", "manager_session[payloadsize_session]"

      assert_select "input[name=?]", "manager_session[pps_session]"

      assert_select "input[name=?]", "manager_session[type_port]"

      assert_select "input[name=?]", "manager_session[sla]"

      assert_select "input[name=?]", "manager_session[status_device]"

      assert_select "input[name=?]", "manager_session[ip_interface_vcx]"

      assert_select "input[name=?]", "manager_session[dp50_p2r]"

      assert_select "input[name=?]", "manager_session[dpmax_p2r]"

      assert_select "input[name=?]", "manager_session[dpmin_p2r]"

      assert_select "input[name=?]", "manager_session[lossPercent_p2r]"

      assert_select "input[name=?]", "manager_session[dp50_r2p]"

      assert_select "input[name=?]", "manager_session[dpmax_r2p]"

      assert_select "input[name=?]", "manager_session[dpmin_r2p]"

      assert_select "input[name=?]", "manager_session[lossPercent_r2p]"

      assert_select "input[name=?]", "manager_session[delay_50]"

      assert_select "input[name=?]", "manager_session[delay_max]"

      assert_select "input[name=?]", "manager_session[delay_min]"

      assert_select "input[name=?]", "manager_session[lossPercent_p2r_p95]"

      assert_select "input[name=?]", "manager_session[lossPercent_r2p_p95]"

      assert_select "input[name=?]", "manager_session[delay_50_p95]"

      assert_select "input[name=?]", "manager_session[delay_max_p95]"

      assert_select "input[name=?]", "manager_session[events_delay50]"

      assert_select "input[name=?]", "manager_session[events_lossp2r]"

      assert_select "input[name=?]", "manager_session[events_lossr2p]"

      assert_select "input[name=?]", "manager_session[accediandevice_id]"

      assert_select "input[name=?]", "manager_session[tx_provider_id]"
    end
  end
end
