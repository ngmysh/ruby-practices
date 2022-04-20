#! /usr/bin/env ruby
# frozen_string_literal: true

COLUMN = 3

def format_entries(entries, column)
  division = entries.length / column
  modulo = entries.length % column

  column_length = division + (modulo.positive? ? 1 : 0)

  # 空文字列でパディング、列の長さで分割、行と列を反転
  entries.sort.dup.fill('', entries.length...(column_length * column)).each_slice(column_length).to_a.transpose
end

def calc_max_length_each_column(two_dimensional_array)
  two_dimensional_array.transpose.map { |column| column.max_by(&:length).size }
end

def show_entries(entries, number_of_columns)
  return if entries.empty?

  formatted_entries = format_entries(entries, number_of_columns)
  max_length_each_column = calc_max_length_each_column(formatted_entries)

  formatted_entries.each do |row|
    row.each_with_index do |entry, column_index|
      unless entry.empty?
        print '  ' if column_index != 0
        print entry.to_s
        print ' ' * (max_length_each_column[column_index] - entry.size)
      end
      puts if column_index == row.size - 1
    end
  end
end

def warn_access_error(entry)
  warn "#{__FILE__}: cannot access '#{entry}': No such file or directory"
end

if ARGV.empty?
  entries = Dir.glob('*')
  show_entries(entries, COLUMN)
else
  files = []
  directories = []

  # アクセスエラー、ファイル、ディレクトリの順で出力
  ARGV.each do |command_line_argument|
    if !File.exist?(command_line_argument)
      warn_access_error(command_line_argument)
    elsif File.directory?(command_line_argument)
      directories << command_line_argument
    else
      files << command_line_argument
    end
  end

  show_entries(files, COLUMN)

  directories.sort.each_with_index do |directory, index|
    puts if !files.empty? || index != 0
    puts "#{directory}:" if !files.empty? || directories.size > 1
    entries = Dir.glob('*', base: directory)
    show_entries(entries, COLUMN)
  end
end
