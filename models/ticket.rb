require_relative('../db/sql_runner.rb')

class Ticket
  attr_reader :id, :customer_id, :film_id, :time
  def initialize(options)
    @id = options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @time = options['time']
  end

  def save
    sql = "INSERT INTO tickets (customer_id, film_id, time) VALUES ('#{@customer_id}', #{@film_id}, '#{@time}') RETURNING id"
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

  def self.all()
    sql = "SELECT * FROM tickets"
    return self.get_many(sql)
  end

  def delete
    sql = "DELETE FROM tickets WHERE id =#{@id}"
    SqlRunner.run(sql)
  end

  def update
    sql = "UPDATE tickets SET (customer_id, film_id) = (#{@customer_id}, #{@films_id}) WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def ticket_count
    sql = "SELECT COUNT(id) FROM tickets"
    result = SqlRunner.run(sql)[0]
    return result['count'].to_i
  end

end