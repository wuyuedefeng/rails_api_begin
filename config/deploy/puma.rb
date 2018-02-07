#!/usr/bin/env puma

app_name = "eatdrink"
app_path = "/mnt/www/#{app_name}"

environment "production"

daemonize true
workers 1
threads 2,16

directory "#{app_path}/current"

bind "unix://#{app_path}/shared/tmp/sockets/puma.sock"
pidfile "#{app_path}/shared/tmp/pids/puma.pid"
state_path "#{app_path}/shared/tmp/sockets/puma.state"
stdout_redirect "#{app_path}/shared/log/puma.stdout.log", "#{app_path}/shared/log/puma.stderr.log"
activate_control_app "unix://#{app_path}/shared/tmp/sockets/pumactl.sock"

daemonize true
on_restart do
  puts 'On restart...'
end
preload_app!