    
    cd infra/
    terraform init
    terraform plan
    terraform apply -auto-approve
    sleep 120s # this sleep is to allow BIG-IP to initialize before we make further deployments in the next commands.
    echo 'sleep for 120 seconds...'
    cd ../
    mv ~/.kube/config ~/.kube/config-backup
    #deploy and configure CIS on 2x clusters
    export KUBECONFIG=infra/kube_config
    kubectl apply -f ingress/cis/customresourcedefinitions.yaml
    kubectl apply -f ingress/cis/secret_sa_rbac.yaml
    kubectl apply -f ingress/cis/cluster1/cis1.yaml
    kubectl apply -f ingress/cis/cluster1/cis2.yaml
    export KUBECONFIG=infra/kube_config1
    kubectl apply -f ingress/cis/customresourcedefinitions.yaml
    kubectl apply -f ingress/cis/secret_sa_rbac.yaml
    kubectl apply -f ingress/cis/cluster2/cis1.yaml
    kubectl apply -f ingress/cis/cluster2/cis2.yaml
    #deploy and configure KIC on 2x clusters
    export KUBECONFIG=infra/kube_config
    kubectl apply -f ingress/nginx/common/ns-and-sa.yaml
    kubectl apply -f ingress/nginx/rbac/rbac.yaml
    kubectl apply -f ingress/nginx/common/default-server-secret.yaml
    kubectl apply -f ingress/nginx/common/nginx-config.yaml
    kubectl apply -f ingress/nginx/common/ingress-class.yaml
    kubectl apply -f ingress/nginx/common/crds/k8s.nginx.org_virtualservers.yaml
    kubectl apply -f ingress/nginx/common/crds/k8s.nginx.org_virtualserverroutes.yaml
    kubectl apply -f ingress/nginx/common/crds/k8s.nginx.org_transportservers.yaml
    kubectl apply -f ingress/nginx/common/crds/k8s.nginx.org_policies.yaml
    kubectl apply -f ingress/nginx/deployment/nginx-ingress.yaml
    kubectl apply -f ingress/nginx/service/service.yaml
    kubectl apply -f ingress/cis/cluster1/tlsprofile.yaml
    kubectl apply -f ingress/cis/cluster1/virtualserver.yaml
    export KUBECONFIG=infra/kube_config1
    kubectl apply -f ingress/nginx/common/ns-and-sa.yaml
    kubectl apply -f ingress/nginx/rbac/rbac.yaml
    kubectl apply -f ingress/nginx/common/default-server-secret.yaml
    kubectl apply -f ingress/nginx/common/nginx-config.yaml
    kubectl apply -f ingress/nginx/common/ingress-class.yaml
    kubectl apply -f ingress/nginx/common/crds/k8s.nginx.org_virtualservers.yaml
    kubectl apply -f ingress/nginx/common/crds/k8s.nginx.org_virtualserverroutes.yaml
    kubectl apply -f ingress/nginx/common/crds/k8s.nginx.org_transportservers.yaml
    kubectl apply -f ingress/nginx/common/crds/k8s.nginx.org_policies.yaml
    kubectl apply -f ingress/nginx/deployment/nginx-ingress.yaml
    kubectl apply -f ingress/nginx/service/service.yaml
    kubectl apply -f ingress/cis/cluster2/tlsprofile.yaml
    kubectl apply -f ingress/cis/cluster2/virtualserver.yaml
    #deploy demo app x 2 clusters
    export KUBECONFIG=infra/kube_config
    kubectl apply -f app/helloworld/ns.yaml
    kubectl apply -f app/helloworld/deployment.yaml
    kubectl apply -f app/helloworld/service.yaml
    kubectl apply -f app/helloworld/ingress.yaml
    kubectl apply -f app/helloworld/externaldns.yaml
    export KUBECONFIG=infra/kube_config1
    kubectl apply -f app/helloworld/ns.yaml
    kubectl apply -f app/helloworld/deployment.yaml
    kubectl apply -f app/helloworld/service.yaml
    kubectl apply -f app/helloworld/ingress.yaml
    kubectl apply -f app/helloworld/externaldns.yaml
    #deploy another demo app x 2 clusters
    export KUBECONFIG=infra/kube_config
    kubectl apply -f app/nginxdemoapp/ns.yaml
    kubectl apply -f app/nginxdemoapp/deployment.yaml
    kubectl apply -f app/nginxdemoapp/service.yaml
    kubectl apply -f app/nginxdemoapp/ingress.yaml
    kubectl apply -f app/nginxdemoapp/externaldns.yaml
    export KUBECONFIG=infra/kube_config1
    kubectl apply -f app/nginxdemoapp/ns.yaml
    kubectl apply -f app/nginxdemoapp/deployment.yaml
    kubectl apply -f app/nginxdemoapp/service.yaml
    kubectl apply -f app/nginxdemoapp/ingress.yaml
    kubectl apply -f app/nginxdemoapp/externaldns.yaml
    # print terraform outputs
    cd infra/
    terraform output
    cd ../
