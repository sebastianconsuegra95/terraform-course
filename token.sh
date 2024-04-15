echo "Digitar MFA: "
read code

CRED=$(aws sts get-session-token --serial-number arn:aws:iam::976859928792:mfa/IPhoneSC --token-code ${code})
echo ${CRED}

AccessKeyId=$(echo ${CRED} | jq -r '.Credentials.AccessKeyId')
SecretAccessKey=$(echo ${CRED} | jq -r '.Credentials.SecretAccessKey')
SessionToken=$(echo ${CRED} | jq -r '.Credentials.SessionToken')

export AWS_ACCESS_KEY_ID=${AccessKeyId}
export AWS_SECRET_ACCESS_KEY=${SecretAccessKey}
export AWS_SESSION_TOKEN=${SessionToken}