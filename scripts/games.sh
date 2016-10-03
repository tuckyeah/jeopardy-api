curl --include --request POST http://localhost:3000/games \
  --header "Content-Type: application/json" \
  --data '{
    "game": {
      "user_id": 1
    }
  }'
