# Api Doc

**Index Post**
----
  Returns json data of all posts.

* **URL**

`/api/posts`

* **Method:**

`GET`

* **Response:**

  * **Code:** 200 <br />
    **Content:**
    ```json
    [ {
    "id": 1,
    "author": {
      "name": "admin",
      "role": "admin",
      "autor_url": "http://lvh.me:3000/users/1.json"
    },
    "title": "Title of admin post",
    "likes": 0,
    "body": "Body of admin post",
    "created_at": "2016-10-02T10:01:36.607Z",
    "url": "http://lvh.me:3000/posts/1.json"
  },
  ... ]
  ```

**Show Post**
----
  Returns json data about a single post.

* **URL**

`/api/posts/:id`

* **Method:**

`GET`

*  **URL Params**

   **Required:**

`id=[integer]`

* **Response:**

  * **Code:** 200 <br />
    **Content:**
    ```json
{
  "id": 1,
  "author": {
    "name": "admin",
    "role": "admin",
    "autor_url": "http://lvh.me:3000/api/users/1"
  },
  "title": "Title of admin post",
  "body": "Body of admin post",
  "created_at": "2016-10-02T10:01:36.607Z",
  "updated_at": "2016-10-02T10:01:36.607Z",
  "likes": []
}
```

**User Sign in**
----
  Returns json data of user session.

* **URL**

`/api/users/sign_in?name=[name]&password=[password]`

* **Method:**

`GET`

*  **URL Params**

   **Required:**

`name=[string]`
 `password=[string]`

* **Success Response:**

  * **Code:** 200 <br />
    **Content:**
    ```json
    {
  "auth_token": [token],
  "instruction": [insturctions]
}
```

* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** 
    ```json
    {
    "error": "Unauthorized."
    }
    ```


**Users Feed**
----
  Returns json data with User's Feed.

* **URL**

`/api/users/feed?auth_token=[auth_token]`

* **Method:**

`GET`

*  **URL Params**

   **Required:**

`auth_token=[string]`

* **Success Response:**

  * **Code:** 200 <br />
    **Content:**
    ```json
    [
  {
    "id": 2,
    "author": {
      "name": "user1",
      "role": "user",
      "autor_url": "http://lvh.me:3000/users/2.json"
    },
    "title": "Title of user post",
    "likes": 0,
    "body": "Body of user post",
    "created_at": "2016-10-02T10:01:36.801Z",
    "url": "http://lvh.me:3000/posts/2.json"
  },
  ... ]
  ```

* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** 
    ```json
    {
    "error": "Unauthorized."
    }
    ```

**Show User**
----
  Returns json data about a single user.

* **URL**

`/api/users/:id`

* **Method:**

`GET`

*  **URL Params**

   **Required:**

`id=[integer]`

* **Success Response:**

  * **Code:** 200 <br />
    **Content:**
    ```json
    {
      "id": 1,
      "name": "admin",
      "email": "adminuser@example.com",
      "role": "admin",
      "likes": 0,
      "was_liked": 0,
      "following": [
        {
          "name": "user1",
          "autor_url": "http://lvh.me:3000/api/users/2"
        }
      ],
      "followers": [
        {
          "name": "user1",
          "follower_url": "http://lvh.me:3000/api/users/2"
        },
        {
          "name": "user2",
          "follower_url": "http://lvh.me:3000/api/users/3"
        }
      ],
      "posts": [
        {
          "title": "Title of admin post",
          "likes": 0,
          "created_at": "2016-10-02T10:01:36.607Z",
          "post_url": "http://lvh.me:3000/api/posts/1"
        }
      ]
    }
    ```

**Admins Index**
----
Returns json data about users.

* **URL**

`/api/users?auth_token=[auth_token]`

* **Method:**

`GET`

*  **URL Params**

      **Required:**

`auth_token=[string]`

* **Success Response:**

     * **Code:** 200 <br />
       **Content:**
       ```json
       [
   {
     "id": 1,
     "provider": null,
     "name": "admin",
     "status": "normal",
     "post_count": 1,
     "likes": 0,
     "was_liked": 0,
     "user_url": "http://lvh.me:3000/api/users/1",
     "followers": [
       {
         "follower_name": "user1",
         "follower_url": "http://lvh.me:3000/api/users/2"
       },
       {
         "follower_name": "user2",
         "follower_url": "http://lvh.me:3000/api/users/3"
       }
     ]
   },
   ... ]
       ```

* **Error Response:**

     * **Code:** 401 UNAUTHORIZED <br />
       **Content:**
    ```json
    {
    "error": "Unauthorized."
    }
    ```
