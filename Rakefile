#!/usr/bin/env ruby
# 
# Warning:  This file is clobbered when you update your
# application with the waves script.  Accordingly, you may
# wish to keep your tasks in .rb or .rake files in lib/tasks
require 'rubygems'
lambda {
  waves = ( ( WAVES if defined? WAVES ) || ENV['WAVES'] || 'waves' )
  $:.unshift(File.join( waves, "lib" )) if File.exist? waves
}.call
require 'waves'

begin
  require 'startup'
  Waves::Console.load(:mode => ENV['mode'])

  # load tasks from waves framework
  %w( cluster generate gem ).each { |task| require "tasks/#{task}.rb" }

  # load tasks from this app's lib/tasks
  Dir["lib/tasks/*.{rb,rake}"].each { |task| require task }
  
rescue LoadError => e
  if e.message == 'no such file to load -- waves'
    puts "Can't find Waves source.  Install gem, freeze Waves, or define WAVES in startup.rb"
    puts
  else
    raise e
  end
end

namespace :dep do

  desc "check if all the dependencies specified in the configuration"
  task :check do

    gems = Gem::SourceIndex.from_installed_gems.to_a.to_s
    missing = Array.new

    puts "\nApplication-level dependencies:"
    puts "  ('*' means gem is installed and available)"
    
    Waves.config.dependencies.each do |dep|
      pattern = /=#{dep}\s/
      print "\t#{dep}:\t\t["
      unless pattern.match(gems).nil?
        print "*]\n"
      else
        print " ]\n"
      end
    end    
  end
  
  desc "install any missing dependencies specified in the configuration"
  task :install do

    gems = Gem::SourceIndex.from_installed_gems.to_a.to_s
    missing = Array.new

    Waves.config.dependencies.each do |dep|
      pattern = /=#{dep}\s/
      missing << dep if pattern.match(gems).nil?
    end

    missing.each do |dep|
      puts "Installing dependency: #{dep}"
      begin
        require 'rubygems/dependency_installer'
        if Gem::RubyGemsVersion =~ /^1\.0\./
          Gem::DependencyInstaller.new(dep).install
        else
          # as of 1.1.0
          Gem::DependencyInstaller.new.install(dep)
        end
      rescue LoadError # < rubygems 1.0.1
        require 'rubygems/remote_installer'
        Gem::RemoteInstaller.new.install(dep)
      end
    end

    puts "Environment complete. Nothing to install." if missing.empty?

  end

end

namespace :waves do
  
  desc "freeze src=<wherever> to ./waves"
  task :freeze do

    target = "#{Dir.pwd}/waves"
    src = ENV['src']
    raise "Please specify the location of waves using src=wherever" unless src
    raise "No directory found at '#{src}'" unless File.directory?(src) 
      
    items = FileList["#{src}/*"]
    puts "Freezing from: #{src}"
    items.each do |item|
      puts "copying #{item}"
      cp_r item, target
    end
    
  end
  
  desc "unfreeze (i.e. delete) the waves source at ./waves"
  task :unfreeze do
    frozen = "#{Dir.pwd}/waves"
    rm_r frozen if File.exist?(frozen)
  end
  
  # Convenience task to allow you to freeze the current Waves
  # source without knowing where it is.  This task only gets
  # defined when the Rakefile successfully loaded Waves and if
  # there's nothing in the way at ./waves
  if defined?(WAVES) && !File.exist?("#{Dir.pwd}/waves")
    namespace :freeze do
      desc "freeze current Waves source to ./waves"
      task :current do
        target = "#{Dir.pwd}/waves"
        current = File.expand_path( WAVES )
        items = FileList["#{current}/*"]
        puts "Freezing from: #{current}"
        items.each do |item|
          puts "copying #{item}"
          cp_r item, target
        end

      end
    end
  end
  
end