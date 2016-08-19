namespace :qiita do
  desc 'Export to qiita'
  task :export => :environment do
    QiitaExporter.exec
  end
end
