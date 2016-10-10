# ReadMe

## Task:

### Часть 1:
  - блог
  - админ, юзеры(админ может давать/забирать права юзерам)
  - юзер создает посты
  - юзер лайкает посты других юзеров
  - юзер подписывается на посты других юзеров
  - юзер удаляет свои посты
  - админ удаляет посты всех
  - админ забирает/возвращает права юзера на создание постов
  - аутентификация(facebook, twitter) без devise!!!
  - session storage - cookies

#### Доработки по первой части:
  - AdminsController - вынести в app/controllers/admin/users_controller
  - по поводу AdminsController#change_role, AdminsController#change_status :
      1. посмотри еще раз на эти экшены и вспомни о DRY и CRUD
      2. я хочу чтобы это было Edit экшеном
  - Если ты сейчас читаешь RUSRails - загляни в раздел strong parameteers и сделай соответственные правки
  - PostController#like, #unlike —> смотри замечания выше
  - SessionsController#create_social —> #create - идея в том что ты “создаешь”! а что именно ты создаешь выносится из контроллера в другое место и с этим ты должен разобраться сам
  - UsersContriller —> #follow, #unfollow, #feed —> опять таки смотри DRY и CRUD
  - По модели Like, теперь я хочу дизлайк. модель Dislike - решение не годится. Вдохновись гемом acts_as_votable, и не используя его сделай решение для лайков и дизлайков

### Часть 2:
  - Photos for user avatars, user collection and posts.
  - Comments for the Posts and Photos. Users can like comments.
  - Bootstrap

## Installation

* Clone or download project and open it
```bash
$ git clone https://github.com/sorefull/Task_1.git && cd Task_1
```
* Install gems
```bash
$ bundle Install
```
* Create database (with seeds)
```bash
$ rails db:migrate && rails db:seed
```
* Now you can serve application
```bash
$ rails s
```

## Api
  [API Documentation](https://github.com/sorefull/Task_1/blob/master/api_doc.md)
