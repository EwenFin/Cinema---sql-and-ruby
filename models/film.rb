require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price, :review

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
    @review = options['review']
  end

  def save()
    sql = "INSERT INTO films (title, price, review) VALUES ('#{@title}', #{@price}, '#{@review}') RETURNING id"
    film = SqlRunner.run(sql)[0]
    @id = film['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def  self.get_many(sql)
    films = SqlRunner.run(sql)
    result = films.map{|film|Film.new(film)}
    return result 
  end

  def self.all()
    sql = "SELECT * FROM films"
    return self.get_many(sql)
  end

  def delete
    sql = "DELETE FROM films WHERE id =#{@id}"
    SqlRunner.run(sql)
  end

  def update
    sql = "UPDATE films SET (title, price, review) = ('#{@title}', #{@price}, '#{@review}') WHERE id = #{@id}"
    SqlRunner.run(sql)
  end
end