#!/bin/bash
#
###############################################################################
# Licensed Materials - Property of IBM.
# Copyright IBM Corporation 2019. All Rights Reserved.
# U.S. Government Users Restricted Rights - Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
#
# Contributors:
#  IBM Corporation - initial API and implementation
###############################################################################
#
# You need to run this script for each namespace.
#
# This script takes one argument; the namespace where the chart will be installed.
#
# Example:
#     ./createSecurityNamespacePrereqs.sh myNamespace
#

if [ "$#" -lt 1 ]; then
	echo "Usage: createSecurityNamespacePrereqs.sh NAMESPACE"
  exit 1
fi

namespace=$1

# Replace the NAMESPACE tag with the namespace specified in a temporary yaml file.
sed 's/{{ NAMESPACE }}/'$namespace'/g' ibm-app-navigator-psp-rb.yaml > $namespace-ibm-app-navigator-psp-rb.yaml

# Create the role binding for all service accounts in the current namespace
kubectl create -f $namespace-ibm-app-navigator-psp-rb.yaml -n $namespace

# Clean up - delete the temporary yaml file.
rm $namespace-ibm-app-navigator-psp-rb.yaml
