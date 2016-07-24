set :environment, "development"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}
every "0 0 28-31 * *" do
  rake "examinations_static:send"
end
