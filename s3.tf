resource "aws_s3_bucket" "this" {
  bucket        = "${var.bucket}-${var.environment}" #interpolação: concatena os dois valores e gera o bucket, basicamente é conseguir concatenar strings com alguma expressão (variavel ou retorno de uma função)
  tags          = local.common_tags
  force_destroy = true #serve para quando tem arquivo dentro do bucket
}

resource "aws_s3_object" "this" { #criando um objeto dentro do bucket
  bucket = aws_s3_bucket.this.bucket
  key    = local.html_filepath          #caminho onde eu quero guardar o arquivo dentro do bucket
  source = local.html_filepath          # onde está o arquivo
  etag   = filemd5(local.html_filepath) # identifica quando o conteudo do arquivo foi alterado para poder subir novamente no bucket
}