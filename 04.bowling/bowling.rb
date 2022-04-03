#!/usr/bin/env ruby
# frozen_string_literal: true

input = ARGV[0]
scores = input.split(',')

shots = []
scores.each do |score|
  shots << if score == 'X'
             10
           else
             score.to_i
           end
end

frames = []
tmp_frame = []
shots.each_with_index do |shot, index|
  tmp_frame << shot
  # トータルのフレームに現在のフレームを追加する条件は次の通り
  # ・(最終フレームではない) && (ストライク || フレームの2投目)
  # ・最後の1投
  next unless ((frames.size != 9) && (shot == 10 || tmp_frame.size == 2)) || (index == shots.size - 1)

  frames << tmp_frame
  tmp_frame = []
end

point = 0
frames.each_with_index do |frame, index|
  point += frame.sum
  bonus = if index != 9 # 最終フレームはボーナスなし
            if frame[0] == 10 # ストライク
              if frames[index + 1][1].nil? # 次のフレームの2投目が存在しない
                frames[index + 1][0] + frames[index + 2][0]
              else
                frames[index + 1][0] + frames[index + 1][1]
              end
            elsif frame.sum == 10 # スペア
              frames[index + 1][0]
            end
          end
  point += bonus unless bonus.nil?
end

puts point
