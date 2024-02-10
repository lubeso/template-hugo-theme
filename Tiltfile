docker_build(
    ref="local/server",
    context=".",
    live_update=[
        sync("./content", "/src/www/content"),
        sync(".", "/src/www/themes/base"),
        run("pnpm install", ["package.json", "pnpm-lock.yaml"]),
    ],
    platform="linux/amd64",
)
k8s_yaml(yaml="kubernetes/server.yaml")
k8s_resource(
    labels=["hugo"],
    workload="server",
    port_forwards=[port_forward(1313, 1313, "http://")],
)