#!/bin/sh

set -e

# Terraform
#
echo "Execute terraform init..."
terraform init

echo "Execute terraform fmt..."
terraform fmt --recursive

echo "Execute terraform-docs..."
terraform-docs markdown --output-file TERRAFORM.md .

echo "Execute terraform sec..."
tfsec .

echo "Execute terraform lint..."
tflint --init
tflint . --force

echo "Validate the examples..."
echo "  integration"
terraform -chdir=./examples/integration init
terraform -chdir=./examples/integration validate
terraform -chdir=./examples/integration plan

echo "  predefined"
terraform -chdir=./examples/predefined init
terraform -chdir=./examples/predefined validate
terraform -chdir=./examples/predefined plan

echo "  security"
terraform -chdir=./examples/security init
terraform -chdir=./examples/security validate
terraform -chdir=./examples/security plan

echo "Clean up local resources..."
rm -rf .terraform
rm .terraform.lock.hcl
