require_relative('../db/sql_runner.rb')

class Ticket
  attr_reader :id, :customer_id, :film_id
  def initialize(options)
    @id = options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ('#{@customer_id}', #{@film_id}) RETURNING id"
    ticket = SqlRunner.run(sql)[0]
    @id = ticket['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

  def self.get_many(sql)
    tickets = SqlRunner.run(sql)
    result = tickets.map{|ticket| Ticket.new(ticket)}
    return result
  end

end