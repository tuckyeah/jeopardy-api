curl --include --request PATCH http://localhost:3000/answers/1 \
  --header "Content-Type: application/json" \
  --data '{
    "clue": {
      "response": "apples"
    }
  }'
