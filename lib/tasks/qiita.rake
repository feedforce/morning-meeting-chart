namespace :qiita do
  desc 'Export to qiita'
  task :export => :environment do
    QiitaExporter.exec if Time.current.wday == 1
  end
end
