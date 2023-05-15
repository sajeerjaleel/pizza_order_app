# README

Tables:

* Order
* Pizza
* Topping
* Size
* Promotion
* Discount
* OrderPizza
* OrderTopping

Database Design:

* Each Order can have many Pizzas through OrderPizzas.
* Each OrderPizza has many Toppings through OrderToppings.
* Each Order has many promotions and 1 Discount
* Each Size have a multiplier value

Setup:

* Tech stack - Ruby on Rails 7, Ruby 3.1.2, Psql, HTML
* Gems used - rubocop, simplecov, minitest, rubycritic
* Update `database.yml` file
* Add `.env` file for your db creds
* Run `rake db:migrate`.
* Run `rake db:seed` for initial data setup.
* Run `rails s` to start the server
* Run `rails test` for test cases
* Run `COVERAGE=true rails test` for rails test coverage report.
* Additionally `rubycritic` can be used to analyse the code quality.

Code analysis:

* Used different services for calculation logic of OrderPrice, pizza price and promotions
* Order total price is stored in the orders table.
* Each pizza price is also stored in corresponding order_pizzas table. The price is updated as a callback with changes in the pizza or toppings.
* Promotion is applied to the order depending upon the promotion logic.

Test Cases:

* Tried to cover possible test cases.
* Used fixtures to populate test data

Further improvement:

Currently only the mentioned scenarios are implemented. Further we can add functionality for different items other than pizza. Also the order creation is not implemennted as it's not required at the moment.
There are further scope of development.

