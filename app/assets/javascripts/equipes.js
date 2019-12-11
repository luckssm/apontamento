function adicionar_usuario(){
  var usuario_id = $("#equipe_usuarios").val();
  console.log("teste");
  $.ajax({
    url: "/equipes/adicionar_membro",
    method: "POST",
    dataType: "script",
    data: {
      'usuario_id': usuario_id,
      'equipe_id': <%= equipe.id %>
    }
  });
}