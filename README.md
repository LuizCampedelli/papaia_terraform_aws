aws configure

para checar:

aws sts get-caller-identity

terraform init

terraform fmt -check >>> checa os arquivos para ver se estão formatados corretamente

terraform fmt -diff >>> mostra as diferenças entre o arquivo
e o formato correto

terraform validate >>> valida a sintaxe do arquivo

terraform plan >>> mostra o que será feito

terraform plan -out plano.tfplan >>> salva o plano em um arquivo

terraform show plano.tfplan >>> mostra o que será feito

terraform apply >>> aplica as mudanças

terraform applu -auto-approve >>> aplica as mudanças sem perguntar
