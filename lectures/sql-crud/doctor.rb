require 'sqlite3'
DB = SQLite3::Database.new("02_sql_crud_doctors.db")

class Doctor
  attr_reader :id, :name, :age

  def initialize(attributes = {})
    @id = attributes["id"]
    @name = attributes["name"]
    @age = attributes["age"]
    @specialty = attributes["specialty"]
  end

  def self.find(id)
  end

  def self.all
  end

  def save
  end

  def destroy
  end
end


john = Doctor.find(1)
# objeto de Doctor

DB.results_as_hash = true

result = DB.execute('SELECT * FROM doctors')

p result

# [[1, "John Smith", 39, "Anesthesiologist"], [2, "Emma Reale", 31, "Cardiologist"]]


john = Doctor.new(result.first)
p john.name
p john.age
