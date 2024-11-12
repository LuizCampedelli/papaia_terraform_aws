![AWS](imgs/AWS.drawio.png.png)

# Ambiente Simulado: “E-commerce de Produtos Digitais”

## Descrição do Cenário:Imagine que você está revisando a arquitetura de um site de e-commerce que vende produtos digitais, como e-books e cursos online. O sistema é configurado para escalar automaticamente em períodos de alta demanda, como em campanhas de marketing e datas de promoção.

## Detalhes da Arquitetura:Este e-commerce foi configurado na AWS com uma arquitetura simplificada para uma startup, incluindo:
1. Front-end:
    * Amazon S3 para armazenar os arquivos estáticos do site.
    * Amazon CloudFront para entrega de conteúdo e CDN.
2. Back-end:
    * Amazon EC2 para hospedar a API que lida com pedidos e login de usuários.
    * Auto Scaling configurado para ajustar a quantidade de instâncias com base na demanda.
3. Banco de Dados:
    * Amazon RDS (MySQL) configurado em uma VPC, em uma única AZ
    * Backups automáticos do banco de dados são feitos diariamente.
4. Armazenamento de Produtos:
    * Amazon S3 para armazenar os arquivos digitais (e-books, cursos).
5. Segurança:
    * AWS IAM gerenciando as permissões para que apenas administradores possam acessar o back-end.
    * Amazon Cognito para autenticação de usuários do front-end.
6. Monitoramento:
    * Amazon CloudWatch monitora o desempenho das instâncias EC2 e envia alarmes para o time técnico.
7. Gerenciamento de Custos:
    * AWS Budgets configurado para alertar se os custos mensais ultrapassarem um limite definido.

Utilize o Well- architected para melhorar a resiliencia da aplicação.Apos o resultado, crie a arquitetura no draw.io e todos os componentes deverao ser entregue via terraform. Nao se esqueca de incluir a arquitetura que voce desenhou e um readme explicando os componentes criados no terraform.

# Como configurar

1. Configurar as credenciais da AWS, tais como chave, chave secreta, região e formato de texto, cria um usuário de IAM, para uso na CLI e adicione as permissões necessãrias a seu projeto, após isso, no terminal digite:

```bash
aws configure
```

2. Para checar suas credenciais corretamente:

```bash
aws sts get-caller-identity
```

3. Usando o Terraform (caso não tenha instalado, seguir os passos de instalação no link: [instalação](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))

2. Usando o Terraform, comando inicializar um repositório:

```bash
terraform init
```

3. Após, o código feito, checar sua formatação:

```bash
terraform fmt -check
```

 * Verifica se os arquivos estão formatados corretamente

```bash
terraform fmt -diff
```

 * mostra as diferenças entre o arquivo e o formato correto

```bash
terraform validate
```

 * Valida a sintaxe do arquivo

```bash
terraform plan
```
 * Mostra o que será feito

```bash
terraform plan -out nome_do_plan.tfplan
```

 * Salva o plano (plan) em um arquivo


```bash
terraform apply -auto-approve
```

 * Aplica as mudanças, sem pedir para confirma-las

```bash
terraform destroy -auto-approve
```
 * Remove todas alterações feitas pelo Terraform a infraestrutura.

### Opcionais do Destroy:

```bash
terraform destroy -target aws_s3_bucket.nome_do_bucket -target
aws_rds_instance.nomde_d0_rds -auto-approve
```
 * adiconar targets (alvos), para serem destruidos

Obrigado
