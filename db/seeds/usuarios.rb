if Usuario.all.count == 0
  Usuario.create(email: "usuario1@gmail.com", password: "testeteste", nome: "Usuario1", tipo: Usuario::GESTOR)
  Usuario.create(email: "usuario2@gmail.com", password: "testeteste", nome: "Usuario2", tipo: Usuario::COLABORADOR)
  Usuario.create(email: "usuario3@gmail.com", password: "testeteste", nome: "Usuario3", tipo: Usuario::COLABORADOR)
end