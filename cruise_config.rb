# this is the file that cruise control uses to configure its own cruise build at 
# http://cruisecontrolrb.thoughtworks.com/
#   simple, ain't it

dProject.configure do |project|
  project.email_notifier.emails = ["jeremystellsmith@gmail.com"]
  project.build_command = "rake db:migrate default selenium_test --trace"
end
