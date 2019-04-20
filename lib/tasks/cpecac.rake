# file: lib/tasks/prueba.rake

desc 'new report CPE CAC'
task new_report_cac: :environment do
  # ... set options if any
  CpecacInterface.create(CpecacInterface.statsinterfacetotal_table)
end
