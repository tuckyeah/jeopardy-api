# GET index
curl --include --request GET 'http://localhost:3000/categories'

# GET show
curl --include --request GET "http://localhost:3000/categories/3"
# POST

curl --include --request POST http://localhost:3000/games \
  --header "Content-Type: application/json" \
  --data '{
    "game": {
      "user_id": 2
    }
  }'

  curl --include --request PATCH http://localhost:3000/answer/6/1 \
    --header "Content-Type: application/json" \
    --data '{
      "clue": {
        "response": "ant"
      }
    }'



# PATCH

# DELETE
