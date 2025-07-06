#!/bin/bash

# Install or upgrade frontend
helm upgrade --install flower-frontend ./helm/frontend

# Install or upgrade backend
helm upgrade --install flower-backend ./helm/backend

echo "✅ Helm deployments applied!"
