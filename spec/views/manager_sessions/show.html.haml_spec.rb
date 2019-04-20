require 'rails_helper'

RSpec.describe "manager_sessions/show", type: :view do
  before(:each) do
    @manager_session = assign(:manager_session, ManagerSession.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Ip Endpoint/)
    expect(rendered).to match(/Name Endpoint/)
    expect(rendered).to match(/Product Endpoint/)
    expect(rendered).to match(/State Endpoint/)
    expect(rendered).to match(/Type Endpoint/)
    expect(rendered).to match(/Capability/)
    expect(rendered).to match(/Port Endpoint/)
    expect(rendered).to match(/Tos Endpoint/)
    expect(rendered).to match(/Name Session/)
    expect(rendered).to match(/Session Type/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/Dst Endpoint/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/Src Endpoint/)
    expect(rendered).to match(/Src Ifc/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/State Session/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(/6.5/)
    expect(rendered).to match(/7.5/)
    expect(rendered).to match(/8.5/)
    expect(rendered).to match(/Type Port/)
    expect(rendered).to match(/Sla/)
    expect(rendered).to match(/Status Device/)
    expect(rendered).to match(/Ip Interface Vcx/)
    expect(rendered).to match(/9.5/)
    expect(rendered).to match(/10.5/)
    expect(rendered).to match(/11.5/)
    expect(rendered).to match(/12.5/)
    expect(rendered).to match(/13.5/)
    expect(rendered).to match(/14.5/)
    expect(rendered).to match(/15.5/)
    expect(rendered).to match(/16.5/)
    expect(rendered).to match(/17.5/)
    expect(rendered).to match(/18.5/)
    expect(rendered).to match(/19.5/)
    expect(rendered).to match(/20.5/)
    expect(rendered).to match(/21.5/)
    expect(rendered).to match(/22.5/)
    expect(rendered).to match(/23.5/)
    expect(rendered).to match(/24/)
    expect(rendered).to match(/25/)
    expect(rendered).to match(/26/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
