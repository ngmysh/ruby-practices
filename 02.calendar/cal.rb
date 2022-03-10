#!/usr/bin/env ruby

require 'date'
require 'optparse'

# -yオプションが指定されたとき、指定された年のDateオブジェクトを返す
def opt_year(year, date)
  Date.new(year, date.month, date.day)
end

# -mオプションが指定されたとき、指定された月のDateオブジェクトを返す
def opt_month(month, date)
  Date.new(date.year, month, date.day)
end

# 月と年を表示
def show_month_year(date)
  puts "#{date.month}月 #{date.year}".rjust(15)
end

# 曜日の文字列を表示
def show_week_string
  puts "日 月 火 水 木 金 土"
end

# カレンダー形式で指定された月の日を表示
def show_days(date)
  index = Date.new(date.year, date.month, 1)
  last = Date.new(date.year, date.month, -1)
  print " " * ((index.cwday % 7) * 3 - 1) if index.cwday % 7 != 0
  loop do
    print " " if index.cwday % 7 != 0
    print index.day.to_s.rjust(2)
    print "\n" if index.saturday?
    if index === last then
      print "\n"
      break
    end
    index = index + 1
  end
end

# カレンダーを表示
def show_calendar(date)
  show_month_year(date)
  show_week_string
  show_days(date)
  print "\n"
end

date = Date.today

# オプションの処理
params = ARGV.getopts("y:m:")
date = opt_year(params["y"].to_i, date) if params["y"]
date = opt_month(params["m"].to_i, date) if params["m"]

# カレンダーを表示
show_calendar(date)
