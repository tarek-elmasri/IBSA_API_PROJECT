# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Client.create(client_id: 1001 , name: "Thuriya Medical Center")
Client.create(client_id: 1002 , name: "Banoon Medical Center")
Client.create(client_id: 1003 , name: "Soliman AL-Habib")
Client.create(client_id: 1004 , name: "Al-Falah Hospital")
Client.create(client_id: 1005, name: "Obiad Hospital")

Employer.create(username: "IBSA Admin" , email: "ibsa_admin@ibsagulf.com" , password: "12345" , password_confirmation: "12345" , role: "GM")