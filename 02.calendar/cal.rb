#!/usr/bin/env ruby

require 'date'
require 'optparse'

def show_month_year(year, month)
  puts "#{month}月 #{year}".rjust(15)
end

def show_week_string
  puts '日 月 火 水 木 金 土'
end

def show_days(year, month)
  first = Date.new(year, month, 1)
  last = Date.new(year, month, -1)
  print ' ' * (3 * first.wday - 1) unless first.sunday?
  (first..last).each do |date|
    print ' ' unless date.sunday?
    print date.day.to_s.rjust(2)
    print "\n" if date.saturday?
  end
  puts
end

def show_calendar(year, month)
  show_month_year(year, month)
  show_week_string
  show_days(year, month)
end

current = Date.today

params = ARGV.getopts("y:m:")
year = params["y"] ? params["y"].to_i : current.year
month = params["m"] ? params["m"].to_i : current.month

show_calendar(year, month)
