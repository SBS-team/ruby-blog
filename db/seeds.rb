# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Tag.delete_all
Post.destroy_all
Admin.delete_all

admin = Admin.create(username: 'admin', nick: "Admin", email: "admin@example.com", password: '123456789', password_confirmation: '123456789')
admin.posts.create(subject: "Starting with Rails?", status: false, message: "Starting with Rails? Starting with Rails? Starting with Rails? Starting with Rails?")
admin.posts.create(subject: "Configuring Models", status: false, message: "The devise method in your models also accepts some options to configure its modules. For example, you can choose the cost of the encryption algorithm with:
devise :database_authenticatable, :registerable, :confirmable, :recoverable, :stretches => 20
Besides :stretches, you can define :pepper, :encryptor, :confirm_within, :remember_for, :timeout_in, :unlock_in and other values. For details, see the initializer file that was created when you invoked the \"devise:install\" generator described above.")
Tag.create(name: 'cucumber')
Tag.create(name: 'asa')
Tag.create(name: 'tag')
Post.first.tags << Tag.last
Post.first.tags << Tag.where(name: 'asa').first
Post.last.tags << Tag.last
Post.last.tags << Tag.where(name: 'cucumber').first
