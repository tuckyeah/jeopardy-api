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


BAhJIiViM2VkYzczMjU5OWQ5MDE0NWMxODRiMjVlYWQxZDgyNAY6BkVG--2fe01592857ec805daa284b173a7b66c3ed0d0aa

curl --include --request PATCH http://localhost:3000/categories/1 \
  --header "Content-Type: application/json" \
  --header "Authorization: Token token=BAhJIiU3MGVmYWU2NTlkYWU4YTkwOGVjY2FjNjkwNWUwOWUwZgY6BkVG--89125cdaa1925f307457ecf6a620024e36f37607" \
  --data '{
    "category": {
      "name": "butts"
    }
  }'

# PATCH

# DELETE
