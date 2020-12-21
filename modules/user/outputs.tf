output "new_developer_power_users_arn" {
  value = aws_iam_user.new_developer_power_users.*.arn
}

# user_id
output "new_developer_power_users_user_id" {
  value = aws_iam_user.new_developer_power_users.*.unique_id
}

# user_name
output "new_developer_power_users_name" {
  value = aws_iam_user.new_developer_power_users.*.name
}

# password
output "new_developer_power_users_password" {
  value = aws_iam_user_login_profile.new_developer_power_users.*.encrypted_password
}

# secret key
output "new_developer_power_users_secret" {
  value = aws_iam_access_key.new_developer_power_users.*.encrypted_secret
}


data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# # access key
# output "new_developer_power_users_iam_smtp_password_v4" {
#   # count = length(aws_iam_user.new_developer_power_users)
#   value = aws_iam_access_key.new_developer_power_users.*.ses_smtp_password_v4
# }
