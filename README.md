# Jeopardy Game - API

Backend API for custom Jeopardy Game.

[Front End Client Repo](https://github.com/tuckyeah/jeopardy-client)

The front-end client is live and playable at <br /> https://tuckyeah.github.io/jeopardy-client/

Created for General Assembly - Web Development Immersive Course.


#### API EndPoints


**User Actions**

| Verb        | URI Pattern           | Controller Action  |
| ------------- |:-------------:| -----:|
| POST      | ```/sign-up``` | ```users#signup``` |
| POST    | ```/sign-in```      |   ```users#signin``` |
| DELETE | ```/sign-out/:id```     |    ```users#signout``` |
| PATCH | ```/change-password/:id```     |    ```users#changepw``` |
| PATCH | ```/reset-score/:id```     |    ```users#reset_score``` |

**Game Actions**
*Must be Authenticated / Signed In to Access.*

Includes standard CRUD actions / paths for Categories and Clues.

Also includes custom path to validate an answer from the client, as
well as a custom user path to reset a u

| Verb        | URI Pattern           | Controller Action  |
| ------------- |:-------------:| -----:|
| PATCH      | ```/answer/:clue_id/:game_id``` | ```clues#validate_answer``` |

Sample Raw Category Response, with single clue:

```
"categories": [
{
  "id": 1,
  "name": "\"FOR\" WORDS",
  "complete": false,
  "clues": [
      {
        "id": 1,
        "question": "In a common saying, it's what some people can't see for the trees",
        "answer": "the forest",
        "answered": false,
        "created_at": "2016-10-05T00:09:08.228Z",
        "updated_at": "2016-10-05T00:09:08.228Z",
        "category_id": 1,
        "value": 100
      }
  },
  ...
]
```
