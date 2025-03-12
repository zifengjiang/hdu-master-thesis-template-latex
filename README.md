# 杭州电子科技大学硕士毕业论文 LaTeX 模版

![HDU Logo](./theme/logo/HDUlogo.png)

本模版用于撰写杭州电子科技大学硕士毕业论文，基于 XeLaTeX 编译，提供盲审版和非盲审版两种样式供选择。

## 文件说明

- **main.tex**论文的主入口文件，通过 XeLaTeX 编译生成最终的 PDF 文件。
- **theme/hduthesis.cls**定义论文模版的文档类文件，其中包含所有格式设置与自定义命令。
- **theme/logo/HDUlogo.pdf**
  杭电校徽文件，在 README 顶部和论文封面中使用。

## 编译说明

- 本模版使用 **XeLaTeX** 进行编译，建议使用 TeX Live 或 MikTeX 最新版本。
- 编译入口为 **main.tex**。在终端下可使用以下命令进行编译：

  ```bash
  xelatex main.tex

  ```
- 编译过程中可能需要运行多次 XeLaTeX 命令以正确生成目录、参考文献等。

## 模版参数

在 **main.tex** 中，通过文档类选项来控制论文样式，例如：

```latex
\documentclass[oneside, nocpsupervisor, blind]{theme/hduthesis}
```

- **oneside**单面排版。如果需要双面排版，可调整为 `twoside`。
- **nocpsupervisor**不显示导师信息。根据实际需要，可以修改或去掉该选项。
- **blind**
  编译为盲审版（匿名评阅）。如需非盲审版，请将选项改为 `noblind`

## 注意事项

- 请确保系统已安装 XeLaTeX 编译环境，并正确配置字体。
- 如需修改模版样式，请参考 `theme/hduthesis.cls` 文件中的说明。
- 论文中引用的图片、图表等素材请放置在相应的文件夹中，并在主文件中正确引用。

---

希望这个 README 对你使用和修改模版有所帮助！
