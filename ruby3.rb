# This will only work on ruby 3 +

puts 'Creating a ractor server...'

server = Ractor.new do
  puts "Server starts: #{self.inspect}"
  Ractor.yield 'Greetings 👋'
  received = Ractor.recv
  puts "Server received a message: #{received}"
end

puts 'Creating a client for the ractor server...'

client = Ractor.new(server) do |srv|
  puts "Client starts: #{self.inspect}"
  received = srv.take
  puts "Client received a messsage from #{srv.inspect}: #{received}"
  srv.send 'Howdy 🤠'
end

[client, server].each(&:take) # wait for results

puts '---'