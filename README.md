[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/intale/ruby-blog)
Installation instruction(under linux):
# RorTeam

## Описание сайта

 Ruby-blog - это блог, целью которого поделится опытом в области разработки на Ruby on Rails.
 На вкладке Home выводится список всех публикаций, написанных нашими разработчиками.
 Эти посты носят информационный и ознакомительный характер и освещают некоторые вопросы связанные с разработкой и поддержкой RubyOnRails приложений.
 Эти статьи могут оказаться полезными как соискателям трудоустройства, так и потенциальным заказчикам при формировании задачи и формулировании технического задания.
 Для более удобного поиска необходимой информации все публикации разделены на категории в зависимости от тематики и имеют соответствующие теги.
 Постоянные посетители нашего сайта могут подписаться на RSS ленту.
 Ha вкладке About Us  размещена краткая информация о каждом члене нашей команды: навыки, опыт


## Requirements

  * ruby 2.0.0p247
  * Rails 4.0.0
  * PostgreSQL > 9.2
## Инструкция по запуску сайта ruby-blog

- Зайти на репизиторий ruby-blog https://github.com/SBS-team/ruby-blog
- Клонировать проект:

        git clone https://github.com/SBS-team/ruby-blog.git

- Перейти в папку с проектом
- Установить гемы:

        bundle install

- Установить nokogiri зависимости
        sudo apt-get install libxml2 libxml2-dev libxslt1.1 libxslt1-dev

- Создать файл настроек подключения к серверу БД 'config/database.yml' на основании файла 'config/database.yml.example'
- Создать БД

        rake db:create

- Выполнить миграции БД

        rake db:migrate

        rake data:admin
- Наполнить БД даными:
        rake db:seed
- В папке с клонированным проектом

        rails s


- Теперь перейдите http://your_host/administration/admins/new чтобы создать нового админа который может создавать посты.

 Откройте ваш браузер и в адресной строке введите localhost:3000

Удачи.