resource "local_file" "productos" {
  content = "lista de productos para el mes proximo"
   filename = "productos.txt"
}