# Development, Staging, Production 환경에 따라 VPC ID를 선택적으로 출력
output "vpc_id" {
  description = "VPC ID for the selected environment"
  value = (
    var.environment == "development" ? module.dev_vpc[0].vpc_id :
    var.environment == "staging" ? module.staging_vpc[0].vpc_id :
    module.prod_vpc[0].vpc_id
  )
}

# Development, Staging, Production 환경에 따라 Web Server의 Public IP 선택적으로 출력
output "web_server_public_ips" {
  description = "Public IPs of the web servers for the selected environment"
  value = (
    var.environment == "development" ? module.dev_web_server[0].public_ips :
    var.environment == "staging" ? module.staging_web_server[0].public_ips :
    module.prod_web_server[0].public_ips
  )
}
