require('pry')
require_relative('./models/ticket.rb')
require_relative('./models/film.rb')
require_relative('./models/customer.rb')


 Ticket.delete_all
 Customer.delete_all
 Film.delete_all

film1 = Film.new({'title' =>'Lego Batman', 'price' =>9.59, 'review' => "all important movies start with a black screen"})

film2 = Film.new({'title' =>'Iron Man 9', 'price' => 7.99, 'review' => "looking a bit rusty"})

film3 = Film.new({'title' =>'Pirates of the Caribbean 12', 'price' => 11.99, 'review' => "Remember when Johnny Depp was good? Pepperidge farm doesn''t"})

film1.save
film2.save
film3.save

customer1 = Customer.new({'name' => 'Ewen', 'funds' => 20.00})

customer2 = Customer.new({'name' => 'Nick', 'funds' => 50.00})

customer3 = Customer.new({'name' => 'Andy', 'funds' => 10.00})

customer1.save
customer2.save
customer3.save

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id, 'time' => 2100})

ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id,'time' => 2100})

ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id,'time' => 1700})

ticket4 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id,'time' => 1500})
ticket5 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id, 'time' => 1500})

ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save

binding.pry
nil