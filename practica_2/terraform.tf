resource "local_file" "productos" {
  content  = "lista de productos para el mes proximo"
  filename = "productos-${random_string.sufijo[count.index].id}.txt"
  count    = 5
}

resource "random_string" "sufijo" {
  count   = 5
  length  = 4
  special = false
  upper   = false
  numeric = false
}
