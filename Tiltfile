def build_server(
    ref = "local/server",
    context = ".",
    sync_target_base_path = "/src/site/themes/custom",
    sync_watch_paths = [
        "archetypes",
        "assets",
        "i18n",
        "layouts",
        "static",
        "hugo.yaml",
        "package.json",
        "pnpm-lock.yaml",
        "theme.toml",
    ],
    platform = "linux/amd64",
):
    docker_build(
        ref=ref,
        context=context,
        live_update=[
            sync(
                watch_path,
                "{}/{}".format(sync_target_base_path, watch_path)
            )
            for watch_path in sync_watch_paths
        ] + [run("pnpm install", ["package.json", "pnpm-lock.yaml"])],
        platform=platform,
    )

def deploy_server(
    yaml = "k8s.yaml",
    labels = ["hugo"],
    workload = "server",
    port_forwards = [port_forward(1313, 1313, "http://")],
):
    k8s_yaml(yaml=yaml)
    k8s_resource(
        labels=labels,
        workload=workload,
        port_forwards=port_forwards
    )

build_server()
deploy_server()