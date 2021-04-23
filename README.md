# DevOps Tools

本仓库允许公共访问，请勿在本仓库中提交敏感信息。

## Scripts

**scripts/setup-chart.sh**:

快速创建一个包含常用资源的 helm chart，默认使用 `markable/markable-base` 的最新版本作为基础模版：

1. 依赖安装

    - 安装 code 命令 (可选)

        - 首先打开 VSCode

        - 使用 command + shift + p (注意window 下使用 ctrl + shift + p ) 然后搜索code，选择 install 'code' command in path

    - 安装 Helm v3

        - Mac amd64
            ```bash
            VERSION=v3.5.4
            curl -LO https://get.helm.sh/helm-${VERSION}-darwin-amd64.tar.gz
            tar -zxf ./helm-${VERSION}-darwin-amd64.tar.gz
            mv darwin-amd64/helm /usr/local/bin/
            ```

        - Linux amd64
            ```bash
            VERSION=v3.5.4
            curl -LO https://get.helm.sh/helm-${VERSION}-linux-amd64.tar.gz
            tar -zxf ./helm-${VERSION}-darwin-amd64.tar.gz
            mv darwin-amd64/helm /usr/local/bin/
            ```

        - Windows amd64, git bash
            ```bash
            # 以下命令纯属瞎编，没有实测过（建议使用 wsl，手动狗头）
            VERSION=v3.5.4
            curl -LO https://get.helm.sh/helm-${VERSION}-windows-amd64.zip
            unzip ./helm-${VERSION}-darwin-amd64.tar.gz
            mv darwin-amd64/helm </path/to/bin/>
            ```

    - 安装 yq
        ```bash
        wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY}.tar.gz -O - |\
            tar xz && mv ${BINARY} /usr/bin/yq
        ```

3. 添加 markable chart 仓库

    ```bash
    helm repo add --username **** --password **** markable https://charts.markable.ai
    ```

4. 下载 setup-chart.sh

    ```bash
    curl -LO https://raw.githubusercontent.com/markable-dev/devops-tools/master/scripts/setup-chart.sh
    chmod +x setup-chart.sh
    ```

5. 在当前目录快速创建一个 helm chart

    ```bash
    ./setup-chart.sh hello-world
    ```
