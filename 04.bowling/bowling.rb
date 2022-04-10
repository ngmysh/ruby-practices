#!/usr/bin/env ruby
# frozen_string_literal: true

def last_frame?(frames)
  frames.size == 9
end

def last_throw?(shots, index)
  index == shots.size - 1
end

def strike?(shot)
  shot == 10
end

def second_throw_in_frame?(frame)
  frame.size == 2
end

input = ARGV[0]
scores = input.split(',')

shots = scores.map { |score| score == 'X' ? 10 : score.to_i }

frames = []
tmp_frame = []
shots.each_with_index do |shot, index|
  tmp_frame << shot
  if last_frame?(frames)
    frames << tmp_frame if last_throw?(shots, index)
  elsif strike?(shot) || second_throw_in_frame?(tmp_frame)
    frames << tmp_frame
    tmp_frame = []
  end
end

point = 0
frames.each_with_index do |frame, index|
  point += frame.sum
  bonus =
    if index != 9 # 最終フレームはボーナスなし
      if frame[0] == 10 # ストライク
        # 次のフレームの2投目が存在しない場合、次の次のフレームの1投目を足す
        frames[index + 1][0] + (frames[index + 1][1] || frames[index + 2][0])
      elsif frame.sum == 10 # スペア
        frames[index + 1][0]
      end
    end
  point += bonus unless bonus.nil?
end

puts point
