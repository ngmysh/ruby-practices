#! /usr/bin/env ruby
# frozen_string_literal: true

COLUMN = 3

def pad_divide(array, number, fill_with)
  division = array.size / number
  modulo = array.size % number
  length = division + (modulo.positive? ? 1 : 0)

  array.dup.fill(fill_with, array.length...(length * number)).each_slice(length).to_a
end

def print_ls_style(entries)
  return if entries.empty?

  # entriesを各列の配列に分割する。
  # 後でtransposeでエラーにならないように、entriesが3で割り切れないときは最後の配列は空文字列パディングする。
  divided_entries = pad_divide(entries.sort, COLUMN, '')

  # 列の表示をそろえるために、各列の中で最大の文字列の長さを記録しておく。
  max_length_each_column = divided_entries.map { |column| column.max_by(&:length).size }

  divided_entries.transpose.each do |row|
    row.each_with_index do |entry, column_index|
      print '  ' if column_index != 0
      print entry.to_s
      print ' ' * (max_length_each_column[column_index] - entry.size)
      puts if column_index == row.size - 1
    end
  end
end

if ARGV.empty?
  entries = Dir.glob('*')
  print_ls_style(entries)
else
  # 引数でファイルやディレクトリが指定された場合、処理される順番は次のようになっていた。（ls (GNU coreutils) 8.32）
  # １．存在しないファイルが渡されるとファイルが見つからない旨のメッセージを標準エラー出力に出力する。
  # ２．渡されたファイル名を全て出力する。
  # 　　引数が"file1 dir1 file2"のようになってても、先にすべてのファイルが表示される。
  # ３．渡されたディレクトリのの中にあるディレクトリエントリを表示する。
  # 　　複数のディレクトリが渡されたときはディレクトリ名の末尾に":"を付けて表示する。
  files = []
  directories = []

  ARGV.each do |command_line_argument|
    if !File.exist?(command_line_argument)
      warn "#{__FILE__}: cannot access '#{command_line_argument}': No such file or directory"
    elsif File.directory?(command_line_argument)
      directories << command_line_argument
    else
      files << command_line_argument
    end
  end

  print_ls_style(files)

  directories.sort.each_with_index do |directory, index|
    puts if !files.empty? || index != 0
    puts "#{directory}:" if directories.size > 1
    entries = Dir.glob('*', base: directory)
    print_ls_style(entries)
  end
end
