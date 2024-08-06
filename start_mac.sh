#!/bin/bash
target="todo"
today=$(date '+%Y-%m-%d')
day=$(date '+%a') # 曜日のみ
month=$(date '+%Y-%m')
first_day_of_month=$(date -v1d +'%Y-%m-%d')
first_day_weekday=$(date -j -f "%Y-%m-%d" "$first_day_of_month" +'%u')

# 日曜日を7に変更
if [ "$first_day_weekday" -eq 7 ]; then
  first_day_weekday=0
fi

# 月曜日始まりの週番号を計算
day_of_month=$(date +'%d')
adjusted_day=$((10#$day_of_month + (first_day_weekday == 0 ? 6 : first_day_weekday - 1)))
week_number=$(((adjusted_day + 6) / 7))

# 週番号が1桁の場合、先頭に0を追加
week=$(printf "week%02d" $week_number)

if [ ! -d "$target" ]; then
  mkdir "$target"
fi

if [ ! -d "$target"/"$month" ]; then
  mkdir "$target"/"$month"
fi

if [ ! -d "$target"/"$month"/"$week" ]; then
  mkdir "$target"/"$month"/"$week"
fi

if [ ! -e  "$target"/"$month"/"$week"/"$today".md ]; then
  cp "template/day.md" "$target"/"$month"/"$week"/"$today".md
  sed -i '' "1s/^/# $today $day\n/" "$target"/"$month"/"$week"/"$today".md
fi

