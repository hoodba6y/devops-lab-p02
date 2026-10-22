#!/bin/bash
# Использование: ./weather.sh Город
CITY="${1:?Укажите город, например: ./weather.sh Perm}"

DATA=$(curl -s --max-time 20 "wttr.in/${CITY}?format=j1")

TEMP=$(echo "$DATA" | jq -r '.current_condition[0].temp_C')
HUM=$(echo "$DATA" | jq -r '.current_condition[0].humidity')

if [ -z "$TEMP" ] || [ "$TEMP" = "null" ]; then
    echo "Не удалось получить погоду для $CITY" >&2
    exit 1
fi

echo '<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Погода</title></head><body>'
echo "<h1>Погода: ${CITY}</h1>"
echo "<p>Температура: ${TEMP} &deg;C</p>"
echo "<p>Влажность: ${HUM}%</p>"
echo "<p>Обновлено: $(date)</p>"
echo "</body></html>"
