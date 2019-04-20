require 'savon'
require 'nokogiri'

f = File.open("service_SapEgrQosQueueStatsLogRecord.xml") 
xml_doc = Nokogiri::XML(f) 
f.close 

xpath = '/SOAP:Envelope/SOAP:Body/xmlns:xmlapi_1'
xml_1 = xml_doc.xpath(xpath)

namespaces = xml_doc.collect_namespaces


xml_doc.at_xpath('/SOAP:Envelope/SOAP:Body/xmlns:xmlapi_1/xmlns:GetSecretResult/xmlns:Secret', ns)