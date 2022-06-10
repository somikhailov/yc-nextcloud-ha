from diagrams import Cluster, Diagram, Edge
from diagrams.aws.network import ELB
from diagrams.aws.network import Route53
from diagrams.onprem.network import Nginx
from diagrams.onprem.certificates import LetsEncrypt
from diagrams.onprem.groupware import Nextcloud
from diagrams.programming.language import Python
from diagrams.onprem.network import Haproxy
from diagrams.onprem.storage import Glusterfs
from diagrams.onprem.network import ETCD
from diagrams.onprem.database import PostgreSQL
from diagrams.onprem.inmemory import Redis
from diagrams.onprem.compute import Server

with Diagram("YC-Nextcloud-HA", show=False, direction="TB"):

    dns = Route53("dns")
    nlb = ELB("nlb")
    bastion = Server("bastion")

    with Cluster("app_proxy"):
        app_proxy0 = Nginx("nginx-app_proxy-0")
        app_proxy0 - Edge(color="darkgreen") - LetsEncrypt("SSL")
        app_proxy1 = Nginx("nginx-app_proxy-1")
        app_proxy1 - Edge(color="darkgreen") - LetsEncrypt("SSL")

    dns >> Edge(color="purple") >> nlb >> Edge(color="purple") >> app_proxy0
    dns >> Edge(color="purple") >> nlb >> Edge(color="purple") >> app_proxy1
        
    with Cluster("patroni"):
        with Cluster("etcd"):
            etcd = [
                ETCD("etcd-0"),
                ETCD("etcd-1"),
                ETCD("etcd-2")
            ]
        with Cluster("db"):
            patroni_master = Python("patroni-master")
            patroni_master - PostgreSQL("psql-master")
            patroni_slave = Python("patroni-slave")
            patroni_slave - PostgreSQL("psql-slave")

            etcd >> Edge(color="blue") << patroni_master 

    with Cluster("redis"):
        redis_master = Redis("redis-master")
        redis_master - Edge(color="red") - Redis("redis-slave") - Edge(color="red") - Redis("redis-slave")
        with Cluster("redis-sentinel"):
            redis_sentinel = [
                Redis("redis-sentinel-0"),
                Redis("redis-sentinel-1"),
                Redis("redis-sentinel-2")
            ]
        redis_master >> Edge(color="red") << redis_sentinel

    with Cluster("app"):
        app0 = Nginx("nginx-app-0")
        haproxy0 = Haproxy("haproxy-app-0")
        app0 >> Edge(color="brown") >> Nextcloud("Nextcloud-app-0") >> Edge(color="brown") >> haproxy0 - Edge(color="brown") - Glusterfs("nextcloud_data")
        app1 = Nginx("nginx-app-1")
        haproxy1 = Haproxy("haproxy-app-1")
        app1 >> Edge(color="brown") >> Nextcloud("Nextcloud-app-1") >> Edge(color="brown") >> haproxy1 - Edge(color="brown") - Glusterfs("nextcloud_data")

    app_proxy0 >> Edge(color="darkgreen", ltail="cluster_app_proxy", lhead="cluster_app") >> app0
    app_proxy1 >> Edge(color="darkgreen", ltail="cluster_app_proxy", lhead="cluster_app") >> app1

    redis_master >> Edge(color="red") << haproxy0
    redis_master >> Edge(color="red") << haproxy1
    patroni_master >> Edge(color="blue") << haproxy0 
    patroni_master >> Edge(color="blue") << haproxy1 
    bastion - app_proxy0
    bastion - app0
    bastion - patroni_master
    bastion - redis_master