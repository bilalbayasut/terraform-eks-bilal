output "new_developer_power_users" {
  value = aws_iam_user.new_developer_power_users
}
data "aws_arn" "new_developer_power_users_account_ids" {
  count = length(aws_iam_user.new_developer_power_users)
  arn   = aws_iam_user.new_developer_power_users[count.index].arn
}
output "new_developer_power_users_arn" {
  value = aws_iam_user.new_developer_power_users.*.arn
}

# account_id
output "new_developer_power_users_account_ids" {
  value = data.aws_arn.new_developer_power_users_account_ids.*.account
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
