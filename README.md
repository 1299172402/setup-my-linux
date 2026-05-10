# setup-my-linux
自动配置新装的Linux系统，使其可以在中国大陆正常使用

```bash
curl -fsSL https://cdn.jsdelivr.net/gh/1299172402/setup-my-linux/setup.sh | bash
```

## 设计说明

所有配置内容都内联在 `setup.sh` 单文件中，不拆分到外部文件。这样 `curl | bash` 只需一次网络请求即可完成，减少因多次下载失败带来的风险。

