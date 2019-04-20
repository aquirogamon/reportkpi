require 'rails_helper'

RSpec.describe "manager_sessions/index", type: :view do
  before(:each) do
    assign(:manager_sessions, [
      ManagerSession.create!(
        :ip_endpoint => "Ip Endpoint",
        :name_endpoint => "Name Endpoint",
        :product_endpoint => "Product Endpoint",
        :state_endpoint => "State Endpoint",
        :type_endpoint => "Type Endpoint",
        :capability => "Capability",
        :port_endpoint => "Port Endpoint",
        :tos_endpoint => "Tos Endpoint",
        :name_session => "Name Session",
        :sessionType => "Session Type",
        :sid => 2.5,
        :dstEndpoint => "Dst Endpoint",
        :dstPort => 3.5,
        :srcEndpoint => "Src Endpoint",
        :srcIfc => "Src Ifc",
        :srcPort => 4.5,
        :state_session => "State Session",
        :interval_session => 5.5,
        :tos_session => 6.5,
        :payloadsize_session => 7.5,
        :pps_session => 8.5,
        :type_port => "Type Port",
        :sla => "Sla",
        :status_device => "Status Device",
        :ip_interface_vcx => "Ip Interface Vcx",
        :dp50_p2r => 9.5,
        :dpmax_p2r => 10.5,
        :dpmin_p2r => 11.5,
        :lossPercent_p2r => 12.5,
        :dp50_r2p => 13.5,
        :dpmax_r2p => 14.5,
        :dpmin_r2p => 15.5,
        :lossPercent_r2p => 16.5,
        :delay_50 => 17.5,
        :delay_max => 18.5,
        :delay_min => 19.5,
        :lossPercent_p2r_p95 => 20.5,
        :lossPercent_r2p_p95 => 21.5,
        :delay_50_p95 => 22.5,
        :delay_max_p95 => 23.5,
        :events_delay50 => 24,
        :events_lossp2r => 25,
        :events_lossr2p => 26,
        :accediandevice => nil,
        :tx_provider => nil
      ),
      ManagerSession.create!(
        :ip_endpoint => "Ip Endpoint",
        :name_endpoint => "Name Endpoint",
        :product_endpoint => "Product Endpoint",
        :state_endpoint => "State Endpoint",
        :type_endpoint => "Type Endpoint",
        :capability => "Capability",
        :port_endpoint => "Port Endpoint",
        :tos_endpoint => "Tos Endpoint",
        :name_session => "Name Session",
        :sessionType => "Session Type",
        :sid => 2.5,
        :dstEndpoint => "Dst Endpoint",
        :dstPort => 3.5,
        :srcEndpoint => "Src Endpoint",
        :srcIfc => "Src Ifc",
        :srcPort => 4.5,
        :state_session => "State Session",
        :interval_session => 5.5,
        :tos_session => 6.5,
        :payloadsize_session => 7.5,
        :pps_session => 8.5,
        :type_port => "Type Port",
        :sla => "Sla",
        :status_device => "Status Device",
        :ip_interface_vcx => "Ip Interface Vcx",
        :dp50_p2r => 9.5,
        :dpmax_p2r => 10.5,
        :dpmin_p2r => 11.5,
        :lossPercent_p2r => 12.5,
        :dp50_r2p => 13.5,
        :dpmax_r2p => 14.5,
        :dpmin_r2p => 15.5,
        :lossPercent_r2p => 16.5,
        :delay_50 => 17.5,
        :delay_max => 18.5,
        :delay_min => 19.5,
        :lossPercent_p2r_p95 => 20.5,
        :lossPercent_r2p_p95 => 21.5,
        :delay_50_p95 => 22.5,
        :delay_max_p95 => 23.5,
        :events_delay50 => 24,
        :events_lossp2r => 25,
        :events_lossr2p => 26,
        :accediandevice => nil,
        :tx_provider => nil
      )
    ])
  end

  it "renders a list of manager_sessions" do
    render
    assert_select "tr>td", :text => "Ip Endpoint".to_s, :count => 2
    assert_select "tr>td", :text => "Name Endpoint".to_s, :count => 2
    assert_select "tr>td", :text => "Product Endpoint".to_s, :count => 2
    assert_select "tr>td", :text => "State Endpoint".to_s, :count => 2
    assert_select "tr>td", :text => "Type Endpoint".to_s, :count => 2
    assert_select "tr>td", :text => "Capability".to_s, :count => 2
    assert_select "tr>td", :text => "Port Endpoint".to_s, :count => 2
    assert_select "tr>td", :text => "Tos Endpoint".to_s, :count => 2
    assert_select "tr>td", :text => "Name Session".to_s, :count => 2
    assert_select "tr>td", :text => "Session Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => "Dst Endpoint".to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => "Src Endpoint".to_s, :count => 2
    assert_select "tr>td", :text => "Src Ifc".to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => "State Session".to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => 6.5.to_s, :count => 2
    assert_select "tr>td", :text => 7.5.to_s, :count => 2
    assert_select "tr>td", :text => 8.5.to_s, :count => 2
    assert_select "tr>td", :text => "Type Port".to_s, :count => 2
    assert_select "tr>td", :text => "Sla".to_s, :count => 2
    assert_select "tr>td", :text => "Status Device".to_s, :count => 2
    assert_select "tr>td", :text => "Ip Interface Vcx".to_s, :count => 2
    assert_select "tr>td", :text => 9.5.to_s, :count => 2
    assert_select "tr>td", :text => 10.5.to_s, :count => 2
    assert_select "tr>td", :text => 11.5.to_s, :count => 2
    assert_select "tr>td", :text => 12.5.to_s, :count => 2
    assert_select "tr>td", :text => 13.5.to_s, :count => 2
    assert_select "tr>td", :text => 14.5.to_s, :count => 2
    assert_select "tr>td", :text => 15.5.to_s, :count => 2
    assert_select "tr>td", :text => 16.5.to_s, :count => 2
    assert_select "tr>td", :text => 17.5.to_s, :count => 2
    assert_select "tr>td", :text => 18.5.to_s, :count => 2
    assert_select "tr>td", :text => 19.5.to_s, :count => 2
    assert_select "tr>td", :text => 20.5.to_s, :count => 2
    assert_select "tr>td", :text => 21.5.to_s, :count => 2
    assert_select "tr>td", :text => 22.5.to_s, :count => 2
    assert_select "tr>td", :text => 23.5.to_s, :count => 2
    assert_select "tr>td", :text => 24.to_s, :count => 2
    assert_select "tr>td", :text => 25.to_s, :count => 2
    assert_select "tr>td", :text => 26.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
