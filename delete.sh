#!/usr/bin/env bash
# Видалення ВСІХ закладок у Shiori — НЕЗВОРОТНО
set -euo pipefail

# 1) Встановити CLI, якщо нема
command -v shiori >/dev/null 2>&1 || {
  echo ">> Встановлюю CLI…"
  npm install -g @shiori-sh/cli
}
command -v jq >/dev/null 2>&1 || {
  echo "!! Потрібен jq: brew install jq"
  exit 1
}

# 2) Авторизація (відкриється браузер — ввійди й дозволь)
echo ">> Авторизація…"
shiori auth

# 3) Зібрати всі ID (по 100 за сторінку) у файл
off=0
: >/tmp/shiori_ids.txt
while :; do
  ids=$(shiori list --json --limit 100 --offset "$off" 2>/dev/null |
    jq -r 'if type=="array" then .[].id else (.links // [])[].id end' |
    sed '/^$/d')
  [ -z "$ids" ] && break
  echo "$ids" >>/tmp/shiori_ids.txt
  n=$(echo "$ids" | wc -l | tr -d ' ')
  [ "$n" -lt 100 ] && break
  off=$((off + 100))
done

total=$(wc -l </tmp/shiori_ids.txt | tr -d ' ')
echo ">> Знайдено закладок: $total"

# 4) Видалити всі (у кошик) + остаточно очистити кошик
shiori delete --ids "$(paste -sd, /tmp/shiori_ids.txt)"
echo ">> Остаточне очищення кошика…"
shiori trash --empty
rm -f /tmp/shiori_ids.txt
echo "✅ Готово — бібліотека очищена ($total)"
