# Defines a custom rake task for generating a report of documentation coverage using +YardStick+.
# Taken from https://github.com/dkubb/yardstick 

# measure coverage
require 'yardstick/rake/measurement'
Yardstick::Rake::Measurement.new(:yardstick) do |measurement|
  measurement.output = 'measurement/yardstick_output.txt'
  measurement.path = 'app/**/*.rb', 'lib/**/*.rb'
end


# verify coverage
require 'yardstick/rake/verify'
Yardstick::Rake::Verify.new do |verify|
  verify.threshold = 100
end