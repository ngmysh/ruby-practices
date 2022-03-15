#!/usr/bin/env ruby

require 'date'
require 'optparse'

def show_month_year(year, month)
  puts "#{month}月 #{year}".rjust(15)
end

def show_week_string
  puts "日 月 火 水 木 金 土"
end

def show_days(year, month)
  first = Date.new(year, month, 1)
  last = Date.new(year, month, -1)
  (first..last).each do |date|
    if date == first && !date.sunday?
      print ' ' * (date.cwday % 7 * 3 - 1) + date.day.to_s.rjust(3)
    elsif date.sunday?
      print date.day.to_s.rjust(2)
    elsif date.saturday?
      print date.day.to_s.rjust(3) + "\n"
    else
      print date.day.to_s.rjust(3)
    end
  end
  puts
end

def show_calendar(year, month)
  show_month_year(year, month)
  show_week_string
  show_days(year, month)
end

current = Date.today

# オプションの処理
params = ARGV.getopts("y:m:")
year = params["y"] ? params["y"].to_i : current.year
month = params["m"] ? params["m"].to_i : current.month

show_calendar(year, month)
