\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{theme/hduthesis}[2015/08/23 hduthesis document class.
	Created: 2014.09.15 by Sky and Hamburger,  Modified by Kwen String at 2016.04.08, Introduced to HDU and then modified by Mingying Huang in 07.07.2018]


%---------- Option ----------
% 博士、硕士可选参数，用于区别格式
\newif\if@cpsupervisor\@cpsupervisortrue
%\DeclareOption{master}{\@doctorfalse}
\DeclareOption{nocpsupervisor}{\@cpsupervisorfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions\relax
\LoadClass[fancyhdr,fntef,cap,openright,a4paper, zihao=-4]{ctexbook}

\newif\if@blind
\DeclareOption{blind}{\@blindtrue}
\DeclareOption{noblind}{\@blindfalse}
\ProcessOptions\relax


%---------- 加载宏包 ----------
\PassOptionsToPackage{no-math}{fontspec}
% 数学公式
\RequirePackage{amsmath, amssymb}
% 公式中的粗体
\RequirePackage{bm}
\RequirePackage{cases}
\RequirePackage{pifont}
\RequirePackage{graphicx}
\RequirePackage{graphicx}
\RequirePackage{enumerate}
\RequirePackage{bigstrut}
\RequirePackage{booktabs,multirow,bookmark}
\RequirePackage[section]{placeins} % 确保图片排版不越过一节
\RequirePackage{geometry}
\RequirePackage{caption}
\RequirePackage{float}
\RequirePackage{subcaption}
\RequirePackage{booktabs}% 三线表
\RequirePackage{longtable}% 长表格宏包，tabu宏包longtabu环境需要。
\RequirePackage{tabu}% 制表宏包，推荐使用，不使用其他制表宏包。
\RequirePackage{ulem}% 下划线
\RequirePackage{array}% 表格处理必备宏包
\RequirePackage{hyperref}% hyperref 宏包可根据交叉引用生成超链接，同时生成 PDF 文档的书签。
\RequirePackage[algoruled, algosection, linesnumbered]{algorithm2e}
\RequirePackage{listings}% 代码排印
\RequirePackage{ragged2e}




\lstset{
	basicstyle=\ttfamily\footnotesize, % 等宽字体
	breaklines=true,
	framextopmargin=30pt,
	framexleftmargin=37pt,
	framexrightmargin=5pt,
	framexbottommargin=5pt,
	%frame=bottomline, % 显示下框线
	columns=fixed,
	stringstyle=\rmfamily\slshape\color[RGB]{128,0,0},   % 设置字符串格式
	showstringspaces=false,                              % 不显示字符串中的空格
	showspaces=false,
	showtabs=false
}

\captionsetup[subfigure]{labelformat=simple} % 防止重复括号
\renewcommand{\thesubfigure}{（\alph{subfigure}）}

\renewcommand{\lstlistingname}{代码}
\renewcommand\figureautorefname{图}
\renewcommand\tableautorefname{表}
\SetAlgorithmName{算法}{算法}

\RequirePackage{pgfplots}
\RequirePackage{pgfplotstable}
\pgfplotsset{compat=newest}
\RequirePackage{tikz}
\usetikzlibrary{chains,scopes,decorations.markings,intersections,patterns,shapes.geometric,shapes.symbols,through,positioning,calc,calendar,arrows,fit,backgrounds,matrix,pgfplots.groupplots,pgfplots.units,spy,pgfplots.colormaps}

% 树状图
\usetikzlibrary{trees}
\newcount\dirtree@lvl
\newcount\dirtree@plvl
\newcount\dirtree@clvl
\def\dirtree@growth{%
	\ifnum\tikznumberofcurrentchild=1\relax
		\global\advance\dirtree@plvl by 1
		\expandafter\xdef\csname dirtree@p@\the\dirtree@plvl\endcsname{\the\dirtree@lvl}
	\fi
	\global\advance\dirtree@lvl by 1\relax
	\dirtree@clvl=\dirtree@lvl
	\advance\dirtree@clvl by -\csname dirtree@p@\the\dirtree@plvl\endcsname
	\pgf@xa=1cm\relax
	\pgf@ya=-1cm\relax
	\pgf@ya=\dirtree@clvl\pgf@ya
	\pgftransformshift{\pgfqpoint{\the\pgf@xa}{\the\pgf@ya}}%
	\ifnum\tikznumberofcurrentchild=\tikznumberofchildren
		\global\advance\dirtree@plvl by -1
	\fi
}

\tikzset{
	dirtree/.style={
			growth function=\dirtree@growth,
			every node/.style={anchor=north},
			every child node/.style={anchor=west},
			edge from parent path={(\tikzparentnode\tikzparentanchor) |- (\tikzchildnode\tikzchildanchor)}
		}
}

\AtEndOfClass{
	\hypersetup{
		unicode,
		% hyperfootnotes=false,
		pdfstartview=FitH,
		CJKbookmarks=true,
		bookmarksnumbered=true,
		bookmarksopen=true,
		% colorlinks=true,		% 链接颜色默认关闭，hidelink打开。
		% citecolor=blue,
		% linkcolor=blue,
		% anchorcolor=blue,
		% urlcolor=blue,
		hidelinks,			% 隐藏超链接的颜色和边框。
		% draft,				% 草稿模式，提高编译速度，需要时注释掉就可以了。
	}
}

\urlstyle{same}

\RequirePackage[sort&compress,numbers]{natbib}% 参考文献正文上标样式设置

\RequirePackage{hypernat}% hypernat 可以让hyperref 和natbib 混合使用，但它需要放在这两者之后。

\RequirePackage[all]{hypcap}% 修复图表超链接不准的问题

% footmisc 宏包提供了对脚注样式的控制功能。
% stable参数主要使脚注\footnote可以用在章节命令中；
% perpage
\RequirePackage[stable,perpage,symbol*]{footmisc}

%---------- 全局命令定义 ----------
% 修改原来CTEX@spaceChar为HDU@spcaeChar，ctex2.0宏包已经没有CTEX@spaceChar命令。
\@namedef{HDU@spaceChar}{\hspace{1em}}
% 用以产生2个字符空格。
\newcommand\HDUspace{\protect\HDU@spaceChar\protect\HDU@spaceChar}

% 封面
\renewcommand*\title[1]{\gdef\HDU@title{#1}}				    	% 论文中文标题
\newcommand*\englishtitle[1]{\long\gdef\HDU@englishtitle{#1}}		% 论文英文标题
\renewcommand*\author[1]{\gdef\HDU@author{#1}}			        	% 作者姓名
\newcommand*\englishauthor[1]{\long\gdef\HDU@englishauthor{#1}}		% 作者英文名
\newcommand*\classification[1]{\gdef\HDU@classification{#1}}		% 分类号
\newcommand*\serialnumber[1]{\gdef\HDU@serialnumber{#1}}			% 单位代码
\newcommand*\secretlevel[1]{\gdef\HDU@secretlevel{#1}}				% 密级
\newcommand*\studentnumber[1]{\gdef\HDU@studentnumber{#1}}			% 学号
\newcommand*\supervisor[1]{\gdef\HDU@supervisor{#1}}				% 指导教师
\newcommand*\englishsupervisor[1]{\gdef\HDU@englishsupervisor{#1}}	% 指导教师英文名
\newcommand*\spvtitle[1]{\gdef\HDU@spvtitle{#1}}			    	% 指导教师职称 
\newcommand*\englishspvtitle[1]{\gdef\HDU@englishspvtitle{#1}}	    % 指导教师英文职称 
\newcommand*\cpsupervisor[1]{\gdef\HDU@cpsupervisor{#1}}			% 合作导师
\newcommand*\cspvtitle[1]{\gdef\HDU@cspvtitle{#1}}		        	% 合作导师职称
\newcommand*\major[1]{\gdef\HDU@major{#1}}				 			% 专业名称
\newcommand*\research[1]{\gdef\HDU@research{#1}}					% 研究方向
\newcommand*\institute[1]{\gdef\HDU@institute{#1}}					% 所在学院
\newcommand*\submitdate[1]{\gdef\HDU@submitdate{#1}}				% 提交日期


% 中文题名页
\newcommand*\defencedate[1]{\gdef\HDU@defencedate{#1}}				% 答辩日期

% 英文题名页
\newcommand*\eendefencedate[1]{\gdef\HDU@eendefencedate{#1}}		% 答辩日期英文版


% 正文部分文字的行距设置
\renewcommand\baselinestretch{1.5} \normalsize
\setlength\baselineskip{20pt}
% 关掉 CTeX 的 1.3 倍行距
% \linespread{1}
% % 关掉 0pt-1pt 的弹性段间距
% \setlength{\parskip}{0pt}
%---------- 版面设置 ----------
% 纸张大小按照A4paper
\setlength\paperheight{297mm}
\setlength\paperwidth {210mm}	%  \paperwidth = h + \oddsidemargin+\textwidth+\evensidemargin + h
% 版心尺寸
\setlength\voffset{20\p@}
%\setlength\hoffset{10\p@}
\setlength\headheight{12\p@}	% 页眉高度
\setlength\headsep{14\p@}		% 页眉与正文间距
\setlength\topskip{20\p@}		% 每页第一行的行间距
\setlength\footskip{30\p@}		% 页脚基线与每一页最后一行文本基线的距离
\setlength\maxdepth{.2\topskip}	% \maxdepth + \topskip = typesize × 1.5
% 软件学院要求版心左、右外边距3.2cm （無理無茶! 简直丑爆了！不能忍）
% 此处缩小了版心外边距到处女座可以接受的值 左边距25mm 右边距23mm 2mm差值消除胶装影响
\setlength\textwidth{16.2cm}	% book.cls文档对texthight和textwidth的
\setlength\textheight{23.7cm}	% 定义比较复杂，但是比较合理
\setlength\marginparsep{10\p@}	% 边注与正文区域的间距
%\setlength\marginparpush{7\p@}	% 两个边注之间的距离，感觉设不设置无所谓
% 单双页面边栏设置
\if@twoside
	\setlength\oddsidemargin{2.6cm}
	\addtolength\oddsidemargin {-1in}
	\setlength\evensidemargin{2cm}
	\addtolength\evensidemargin {-1in}
	\setlength\marginparwidth{45\p@}
\else
	\setlength\oddsidemargin{2.5cm}		% 根据要求，默认单面打印左边距为2.5cm。
	\addtolength\oddsidemargin {-1in}	% 发现latex2e默认在页面四周各留出1in的空白，所以要减去这1in。
	\setlength\evensidemargin{2.0cm}
	\addtolength\evensidemargin {-1in}	% oneside下奇偶页侧边空白相同。
	\setlength\marginparwidth{50\p@}
\fi


% 设置topmargin的尺寸
\setlength\topmargin{\paperheight}
\addtolength\topmargin{-2in}
\addtolength\topmargin{-\headheight}
\addtolength\topmargin{-\headsep}
\addtolength\topmargin{-\textheight}
\addtolength\topmargin{-\footskip}
\addtolength\topmargin{-.5\topmargin}

% 双面打印时空白页中间显示文本
\newcommand*{\HDU@blankpage}{%
	\footnotetext{留白（This page is intentionally left blank）}
}
% 重新定义cleardouble，其原始定义在
\def\cleardoublepage{%
	\clearpage
	\if@twoside
		\ifodd
			\c@page
		\else
			% 下面这个命令，如果不需要强调这是空白页，或者学校不允许，则可将其注释掉。
%			\HDU@blankpage
			\thispagestyle{HDU@empty}%
			\hbox{}\newpage
			\if@twocolumn
				\hbox{}\newpage
			\fi
		\fi
	\fi
}

%---------- 页眉页脚 ----------
% 采用latex2e的底层代码，不用fancyhdr宏包。
% 页眉标记
%\def\HDU@D@M@thesis{杭州电子科技大学硕士学位论文} 
%\def\HDU@D@M@thesis{浙江省硕士学位论文}
\if@blind
	\def\HDU@D@M@thesis{浙江省硕士学位论文}
\else
	\def\HDU@D@M@thesis{杭州电子科技大学硕士学位论文}
\fi

% 空白页：没有页眉页脚和页码
\def\ps@HDU@empty{%
	\let\@oddhead\@empty%
	\let\@evenhead\@empty%
	\let\@oddfoot\@empty%
	\let\@evenfoot\@empty}

% plain样式：只有页脚居中页码
\def\ps@HDU@plain{%
	\let\@oddhead\@empty%
	\let\@evenhead\@empty%
	\def\@oddfoot{\hfil\zihao{-5}\thepage\hfil}%
	\let\@evenfoot=\@oddfoot
}


%页眉为: 宋体五号字，居中，距边界2厘米；
\def\ps@HDU@headings{%
	\def\@oddhead{\vbox to\headheight{  %%\def\HDU@D@M@thesis{杭州电子科技大学硕士学位论文}
			\hb@xt@\textwidth{\zihao{5}\songti\centerline{\HDU@D@M@thesis}\hfill}%将\leftmark放到大括号内即可
			\vskip2pt\hbox{\vrule width\textwidth height0.4pt depth0pt}}}
	\let\@evenhead=\@oddhead
	\def\@oddfoot{\hfil\zihao{-5}\thepage\hfil}
	\let\@evenfoot=\@oddfoot
	\let\@mkboth\markboth
}

%如果页眉中需要标明每章的标题，可以使用下列命令定义\leftmark 然后将\leftmark放到310行\hfiil后即可
%重新定义\chaptermark，使其为\leftmark引用。
\renewcommand\chaptermark[1]{%
	\markboth{\MakeUppercase{%
			\ifnum \c@secnumdepth >\m@ne
				\if@mainmatter
					\@chapapp  \hskip1em%
				\fi
			\fi
			#1}}{}}

%---------- 本机字体设置 ----------
% 设置英文字体为 TeX Gyre 系列字体为 TeX Gyre Termes / Heros / Cursor，它们兼容 Times / Helvetica / Courier
\setromanfont{texgyretermes-regular.otf}[BoldFont=texgyretermes-bold.otf,BoldItalicFont=texgyretermes-bolditalic.otf,ItalicFont=texgyretermes-italic.otf]
\setsansfont{texgyreheros-regular.otf}[BoldFont=texgyreheros-bold.otf,BoldItalicFont=texgyreheros-bolditalic.otf,ItalicFont=texgyreheros-italic.otf]
\setmonofont{texgyrecursor-regular.otf}[BoldFont=texgyrecursor-bold.otf,BoldItalicFont=texgyrecursor-bolditalic.otf,ItalicFont=texgyrecursor-italic.otf,Ligatures=NoCommon]

% 设置中文字体为中易系列字体，如果在非 Microsoft Windows 环境下使用，可能需要安装这些字体
\newfontfamily{\HDU@SimSun}{SimSun}[Path=fonts/,AutoFakeBold=1.5,AutoFakeSlant=0.25]
\newfontfamily{\HDU@SimHei}{SimHei}[Path=fonts/,AutoFakeBold=1.5,AutoFakeSlant=0.25]
\newfontfamily{\HDU@SimKai}{KaiTi}[Path=fonts/,AutoFakeBold=1.5,AutoFakeSlant=0.25]
\setCJKfamilyfont{zhsong}{SimSun}[Path=fonts/,AutoFakeBold=1.5,AutoFakeSlant=0.25]
\setCJKfamilyfont{zhhei}{SimHei}[Path=fonts/,AutoFakeBold=1.5,AutoFakeSlant=0.25]
\setCJKfamilyfont{zhfang}{FangSong}[Path=fonts/,AutoFakeBold=1.5,AutoFakeSlant=0.25]
\setCJKfamilyfont{zhkai}{KaiTi}[Path=fonts/,AutoFakeBold=1.5,AutoFakeSlant=0.25]
\setCJKromanfont{SimSun}[Path=fonts/,AutoFakeBold=1.5,ItalicFont={FangSong}]
\setCJKsansfont{SimHei}[Path=fonts/,AutoFakeBold=1.5,ItalicFont={KaiTi}]
\setCJKmonofont{FangSong}[Path=fonts/,AutoFakeBold=1.5,ItalicFont={FangSong}]

%---------% 封面及中英标题页 ----------
% 定义封面及标题页设置中常用的下划线命令（默认宽度90pt）
\renewcommand\ULthickness{0.8pt}			% 重新定义下划线的厚度
\newcommand\HDUunderline[2][90pt]{\uline{\hbox to #1{\hss#2\hss}}\hskip3pt}
% 重新定义\maketitle命令
\renewcommand\maketitle{
%	\@mainmatterfalse
	\if@blind
		\makeblindpage
	\else
		\HDUmakecover
		\HDUmakeCNtitlepage
		\HDUmakeENtitlepage % 软件学院硕士论文要求显示英文题名页
		\makeOSpage
	\fi
}
% 封面
\newcommand\HDUmakecover{
	\cleardoublepage
	\pdfbookmark[0]{封面}{anchor_cover}
	\thispagestyle{HDU@empty}

	\begin{center}
		\includegraphics[width=160mm]{theme/logo/HDUlogo.pdf}\par
		\vspace{10mm}
		{
			{\zihao{2}\songti\bfseries 硕\hspace{1em}士\hspace{1em}学\hspace{1em}位\hspace{1em}论\hspace{1em}文}
		}\par
		% \vspace{10mm}
		% {
		%     {\zihao{2}\songti\bfseries 详细摘要}
		% }\par
		\vspace{36mm}
	\end{center}
	\vspace{6mm}
	% 新建一个长度寄存器，存放封面标题下划线宽度值
	\newlength{\titleulwidth@cover}
	\addtolength{\titleulwidth@cover}{260pt}
	\begin{center}
		\begin{tabular}[t]{>{\zihao{-2}\songti\bfseries}rl}
			题\,\,\,目: &
			{\begin{minipage}[t][60pt][t]{\titleulwidth@cover}
						 \zihao{-2} \kaishu
						 \uline{\HDU@title\hfill}
					 \end{minipage}
				}
		\end{tabular}

		\vskip 9mm
		\begin{tabular}{>{\zihao{3}\songti\bfseries}l>{\zihao{3}\fangsong}l}
			研\,\,\,究\,\,\,生            & \HDUunderline[200pt]{ \kaishu{\HDU@author} \hspace{1em}}                           \\[3mm]
			专\,\,\,\,\,\,\,\,\,\,\,\,业 & \HDUunderline[200pt]{\kaishu{\HDU@major} \hspace{1em}}                             \\[3mm]
			指导教师                       & \HDUunderline[200pt]{\kaishu{\HDU@supervisor} \hspace{1em} \kaishu{\HDU@spvtitle}} \\[3mm]
		\end{tabular}
	\end{center}
	\vskip 20mm
	\begin{center}
		{\zihao{4}\songti\bfseries 完成日期 \hspace{1em} \HDUunderline[150pt]{\mdseries\kaishu{\HDU@submitdate}}}
	\end{center}
}

\newcommand\makeblindpage{
	\cleardoublepage
	\pdfbookmark[0]{封面}{anchor_blind}
	\thispagestyle{HDU@empty}{
		\newgeometry{top=2.5cm, bottom=2.5cm, left=2.7cm, right=2.7cm}
%		\linespread{1.3}
		%\vspace*{8mm}
		%	\vspace*{-2mm}
		\begin{flushleft}
		{
			\zihao{5}\songti\bfseries
			\setlength{\baselineskip}{49pt}
			\noindent\ding{72}全日制专业学位研究生\par
		}
		\end{flushleft}

		\vspace*{28mm}

		\begin{center}
			{\fontsize{30pt}{49pt}\selectfont\songti\bfseries
				浙\hspace{0.5em}江\hspace{0.5em}省\hspace{0.5em}硕\hspace{0.5em}士\hspace{0.5em}学\hspace{0.5em}位\hspace{0.5em}论\hspace{0.5em}文}
		\end{center}
		\vspace{40mm}
		
		{
			\zihao{-2}\songti
			\setlength{\parindent}{1.01cm}
			\setlength{\baselineskip}{41pt}
			\indent 论文题目：\HDU@title \par
			\indent \mbox{}\par
			\indent 专业学位类别（领域）：\HDU@major\par
			\indent \mbox{}\par
			\indent 研究方向：\HDU@research\par
		}
		
		\vspace{35mm}
		\restoregeometry
		
	}

}


% 中文题名页 中文扉页上论文题目为黑体小一号字，研究生姓名、指导教师姓名、职称为楷体三号字，完成日期为楷体四号字；
\newcommand\HDUmakeCNtitlepage{
	\cleardoublepage
	\pdfbookmark[0]{中文题名页}{anchor_cntitle}
	\thispagestyle{HDU@empty}

	\linespread{1.3}
	\vspace*{2mm}

	%该项字体设置在《杭州电子科技大学研究生学位论文格式统一要求（杭电研[2012]311号）》没有明确规定 默认为楷体二号字
	\begin{center}
		{\zihao{2}\songti\bfseries 杭州电子科技大学硕士学位论文}
	\end{center}
	\vspace{60mm}

	\begin{center}
		{\zihao{-1}\heiti\bfseries\HDU@title  \\[10mm]}
	\end{center}
	\vspace{40mm}

	\begin{center}
		\begin{tabular}{>{\zihao{3}\songti\bfseries}r>{\zihao{3}\kaishu}l}
			研\,\,\,究\,\,\,生： & {\HDU@author \hspace{1em}}                   \\[10mm]
			指导教师：            & {\HDU@supervisor \hspace{1em} \HDU@spvtitle} \\
		\end{tabular}
	\end{center}
	\vspace{40mm}

	\begin{center}
		{\zihao{4}\kaishu{\HDU@defencedate}}
	\end{center}

}

% 英文题名页
\newcommand\HDUmakeENtitlepage{
	\cleardoublepage
	\pdfbookmark[0]{英文题名页}{anchor_entitle}
	\thispagestyle{HDU@empty}

	\linespread{1.3}
	%\vspace*{8mm}
	\vspace*{2mm}

	\begin{center}
		{\zihao{4}\bfseries Dissertation Submitted to Hangzhou Dianzi University \\ for the Degree of Master}

	\end{center}
	\vspace{50mm}

	\begin{center}
		{\zihao{-1}\bfseries \HDU@englishtitle \\[10mm]}
	\end{center}
	\vspace{40mm}

	\begin{center}
		\begin{tabular}{>{\zihao{3}\bfseries}r>{\zihao{3}\bfseries }l}
			Candidate:  & {\HDU@englishauthor \hspace{1em}}                               \\[10mm]
			Supervisor: & {\HDU@englishspvtitle\,\,\,\HDU@englishsupervisor \hspace{1em}} \\
		\end{tabular}
	\end{center}
	\vspace{35mm}

	\begin{center}
		{\zihao{4}\bfseries{\HDU@eendefencedate}}
	\end{center}
}



% 独创声明与版权协议转让页 原创性声明：采用杭电的统一格式，标题为宋体四号，内容为宋体小四号字体
\newcommand\makeOSpage{%
	\cleardoublepage
	\pdfbookmark[0]{原创性声明}{anchor_os}
	\thispagestyle{HDU@empty}
	{
		\newcommand\signature@date{日期：\hspace{8ex}年\hspace{4ex}月\hspace{4ex}日}

		\linespread{1.7}			% 相当于word中的1.5倍行距。
		\songti\zihao{-4}\vspace{-2ex} % 1 ex = 当前字体尺寸中 x 的高度
		\begin{center}
			\songti\zihao{3}\bfseries 杭州电子科技大学

			\songti\zihao{3}\bfseries 学位论文原创性声明和使用授权说明
		\end{center}
		\vspace{20pt}

		\begin{center}
			\songti\zihao{4}\bfseries 原创性声明
		\end{center}
		\vspace{20pt}

		本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究工作所取得%
		的成果。除文中已经注明的引用的内容外，本论文不含任何其他个人或集体已经发表%
		或撰写过的作品和成果。对本文的研究做出重要贡献的个人和集体，均已在文中以%
		明确方式标明。申请学位论文与资料若有不实之处，本人承担一切相关责任。
		\vspace{30pt}

		\begin{center}
			学位论文作者签名：\hspace{13ex} \signature@date
		\end{center}

		\vspace{30pt}
		\begin{center}
			\songti\zihao{4}\bfseries  学位论文使用授权说明
		\end{center}
		\vspace{20pt}
		本人完全了解杭州电子科技大学关于保留和使用学位论文的规定，即：研究生在校攻读%
		学位期间论文工作的知识产权单位属杭州电子科技大学。本人保证毕业离校后，发表论文%
		或使用论文工作成果时署名单位仍然为杭州电子科技大学。学校有权保留送交论文的复应件，%
		允许查阅和借阅论文；学校可以公布论文的全部或者部分内容，可以允许采用影印、缩印或其它复制手段保存论文。%
		（保密的论文在解密后遵守此规定）\\[30pt]
		\begin{center}
			论文作者签名：\hspace{13ex} \signature@date \\[20pt]
			指导教师签名：\hspace{13ex} \signature@date
		\end{center}
	}
}



%---------- 层次标题格式设置 ----------
\setcounter{secnumdepth}{4}		%设置为四级标题
\renewcommand\@chapapp{第\thechapter 章}%

% 以下对标题格式采用laTeX2e底层命令主要是为了防止ctex宏包升级改变导致的命令不兼
% 容性，假如2.0之后宏包对1.02宏包命令不再支持，以后又要修改，不如一鼓作气。
% 现在以下命令可以正常工作，调整参数则慢慢来吧。

%% 章标题格式设置----小三仿宋加黑
\renewcommand\chapter{%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \phantomsection			% hyperref宏包的命令，超链接用。
  % 软件学院和计算机学院规定每章的第一页也要有页眉
  % 可是为什么？为什么一定要这样呢？一点都不美观的说(￣^￣)
  % \thispagestyle{HDU@plain}
  \global\@topnum\z@%
  \@afterindenttrue%
  \secdef\@chapter\@schapter}

\def\@chapter[#1]#2{%
	\ifnum \c@secnumdepth >\m@ne
		\if@mainmatter
			\refstepcounter{chapter}%
			\addcontentsline{toc}{chapter}{\protect\numberline{\@chapapp}#1}
		\else
			\addcontentsline{toc}{chapter}{#1}%
		\fi
	\else
		\addcontentsline{toc}{chapter}{#1}%
	\fi
	\chaptermark{#1}%
	% 在图目录和表目录中相应章节位置加垂直10pt的空白。
	%\addtocontents{lof}{\protect\addvspace{10\p@}}%
	%\addtocontents{lot}{\protect\addvspace{10\p@}}%
	\@makechapterhead{#2}
	\@afterheading}		% 不知道这个\@afterheading有什么用，先放着。

\def\@makechapterhead#1{%
	\vspace*{20\p@}%
	{\parindent \z@ \centering
		\heiti\zihao{3} %\bfseries %% 修改各节标题为黑体四号字，各小节标题为黑体小四号字，均靠左。 %% ydar
		\ifnum \c@secnumdepth >\m@ne
			\if@mainmatter
				\@chapapp \hskip1em%
			\fi
		\fi
		\interlinepenalty\@M
		#1\par\nobreak
		\vskip 24\p@}}


% 新建一个章节标题宏，用法跟\chapter一样，只不过在无星号时，标题插入目录，但是没
% 有页码和中间点线。加星号功能跟\chapter一样，主要为了兼容。\mainmatter中chapter
% 编号计数器不变\npchapter和\chapter都为chapter计数器。
\newcommand\npchapter{
	\if@openright\cleardoublepage\else\clearpage\fi%
	\phantomsection			% hyperref宏包的命令，超链接用。
	%\thispagestyle{HDU@plain}%
	\global\@topnum\z@%
	\@afterindenttrue%
	\secdef\@npchapter\@schapter}
\def\@npchapter[#1]#2{%
	\ifnum \c@secnumdepth >\m@ne
		\if@mainmatter
			\refstepcounter{chapter}%计数器不变
			\addcontentsline{toc}{nopagechapter}{\protect\numberline{\@chapapp}#1}
		\else
			% Kwen 目录页码改造
			%\addcontentsline{toc}{nopagechapter}{#1}%
		\fi
	\else
		\addcontentsline{toc}{chapter}{#1}%
	\fi
	\chaptermark{#1}%
	% 在图目录和表目录中相应章节位置加垂直10pt的空白。
	%\addtocontents{lof}{\protect\addvspace{10\p@}}%
	%\addtocontents{lot}{\protect\addvspace{10\p@}}%
	\@makechapterhead{#2}
	\@afterheading}

%% 1.1 ----小3号黑体
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {1ex}%{3.5ex \@plus 1ex \@minus .2ex}%
  {2.3ex \@plus.2ex}%
  {\parindent \z@ \raggedright\heiti\zihao{-3}}
 } %\bfseries ydar

%% 1.1.1 ----4号黑体
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
	{1ex}%{3.25ex \@plus 1ex \@minus .2ex}%
	{1.5ex \@plus.2ex}%
	{\parindent \z@ \raggedright\heiti\zihao{4}}
} %\bfseries ydar

%% 1.1.1.1 ---小4号黑体 
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
	{1ex}%{3.25ex \@plus 1ex \@minus .2ex}%
	{1.5ex \@plus.2ex}%
	{\parindent \z@ \raggedright\heiti\zihao{-4}\bfseries }
}

%%四级节标题格式设置---小4号黑体加粗
% \renewcommand\subsubsubsection{\@startsection{subsubsubsection}{4}{\z@}%
% 									{3.25ex \@plus 1ex \@minus .2ex}%
% 									{1.5ex \@plus.2ex}%
% 									{\parindent \z@ \raggedright
% 									 \heiti\zihao{-4}}}


% \abstractmatter \frontmatter,\mainmatter,\backmatter重定义。
\newcommand\abstractmatter{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\pagenumbering{Roman}
	\@mainmatterfalse
	\pagestyle{HDU@headings}}
\renewcommand\frontmatter{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\pagenumbering{Roman}
	\@mainmatterfalse
	\pagestyle{HDU@headings}}
\renewcommand\mainmatter{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\@mainmattertrue
	\pagenumbering{arabic}
	\pagestyle{HDU@headings}}
\renewcommand\backmatter{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\@mainmatterfalse}

% 对\appendix进行重新定义，使之可以在\backmatter之后产生章节标题序号，且在书签栏
% 和目录上点击后可以正常跳转到相应的标题项。放弃原来对 \appendix的修改，在前部加
% 上\mainmattertrue会导致书签和目录项跳转产生问题。
\let\OLDappendix\appendix
\newif\if@appendixinbackmatter
\renewcommand\appendix{
	\if@mainmatter
		\@appendixinbackmatterfalse
		\OLDappendix
	\else
		\@appendixinbackmattertrue
		\@mainmattertrue
		\OLDappendix
		\renewcommand\@chapapp{附录~\thechapter}
		\gdef\thechapter{\@Alph\c@chapter}
	\fi}

%---------- 三种目录 ----------
\renewcommand{\contentsname}{目\texorpdfstring{\HDUspace}{}录}				% 重命名章节目录名。
\renewcommand{\listfigurename}{图\texorpdfstring{\HDUspace}{}目\texorpdfstring{\HDUspace}{}录}			% 重命名插图目录名。
\renewcommand{\listtablename}{表\texorpdfstring{\HDUspace}{}目\texorpdfstring{\HDUspace}{}录}				% 重命名表目录名。

% 下一条命令作用：在toc目录文件中插入‘\let\CTEX@spaceChar\relax’字符，用以删除目
% 录中的空格字符，其空格字符由\CTEX@spaceChar定义。
\addtocontents{toc}{\let\string\HDU@spaceChar\relax}

% 目录位置尺寸设置
\renewcommand\@pnumwidth{1.55em}		% 放页码page这个盒子的宽度
\renewcommand\@tocrmarg{2.55em}			% 这个参数怎么没用，改动后看不到效果
\renewcommand\@dotsep{2.2} 				% 目录点间的距离
\setcounter{tocdepth}{2}				% 目录深度，到subsubsection。

%% 章节目录
\renewcommand\tableofcontents{%
	% 使用\npchapter，将标题插入目录，但是不产生页码和中间点线。
	\npchapter{\contentsname}
	\markboth{\contentsname}{}
	\@starttoc{toc}}

% 发现latex2e源码中有这么一行：\def\contentsline#1{\csname l@#1\endcsname}这样一
% 下子就明白了，以\l@*** 开头的命令的两个参数就是\contentsline使用说明的三个参数
% 中的后面两个参数，虽然定义的时候\contentsline只有一个参数。
% #1为目录内容，可以加上章节号title，\chapter中有定义；#2为页码page。
\renewcommand*\l@chapter[2]{%
	\ifnum \c@tocdepth >\m@ne
		\addpenalty{-\@highpenalty}%
		% 下一行增加新一章章节标题在目录中与前面部分的间距
		% \vskip 2\p@ \@plus\p@
		% 下一行是章节序号所在box的宽度
		\setlength\@tempdima{1.5em}%
		\begingroup
		\parindent \z@ \rightskip \@pnumwidth
		\parfillskip -\@pnumwidth
		\leavevmode
		\advance\leftskip\@tempdima
		\hskip -\leftskip
		\songti \zihao{-4} #1\nobreak
		% 下两行是增加章节标题项的中间点
		\leaders\hbox{$\m@th%
				\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
		\nobreak\hb@xt@\@pnumwidth{\hss #2}\par
		\penalty\@highpenalty
		\endgroup
	\fi}

% 这个样式主要是为“目录”这个标题在目录页中的样式服务的，模板中要求“目录”没有页码
% 和中间点连接线，所以弄了这么个nopagechapter目录格式。你说我为什么不用其他方法，
% 这也是没办法，hyperref 宏包把\addcontentsline和\contentsline改了，主要是为了超
% 链接用，如果我把他们重新定义，超链接就会失效。
\newcommand*\l@nopagechapter[2]{%
	\ifnum \c@tocdepth >\m@ne
		\addpenalty{-\@highpenalty}%
		\setlength\@tempdima{1.5em}%
		\begingroup
		\parindent \z@ \rightskip \@pnumwidth
		\parfillskip -\@pnumwidth
		\leavevmode
		\advance\leftskip\@tempdima
		\hskip -\leftskip
		\fangsong\zihao{-4} #1\nobreak\hfill
		\nobreak\hb@xt@\@pnumwidth{\hss}\par
		\penalty\@highpenalty
		\endgroup
	\fi}

% \@dottedtocline定义了5个参数，但是一下命令里只使用了两个，后面两个其实原理跟上
% 面介绍的一样，\contentsline带有3个参数，第一个参数展开后形成\l@***的命令，然后
% \l@***再展开，形成带有3个参数的\@dottedtocline{}{}{}，\@dottedtocline还需title
% 和page两个参数，而\contentsline剩下的两个参数刚好是title和page。
\renewcommand*\l@section{\@dottedtocline{1}{2em}{2.1em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{4em}{3em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{6em}{3.8em}}

%% 图目录
\renewcommand\listoffigures{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\chapter{\listfigurename}
	\@starttoc{lof}}

\renewcommand*\l@figure{\@dottedtocline{1}{0\p@}{2.3em}}

%% 表目录
\renewcommand\listoftables{%
	\if@openright\cleardoublepage\else\clearpage\fi%
	\chapter{\listtablename}
	\@starttoc{lot}}

\let\l@table\l@figure

% ---------- 参考文献样式 ----------
% 修改thebibliography 环境用于在目次中加入参考文献页。
\renewenvironment{thebibliography}[1]
{\chapter{\bibname}%
	\@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
	\list{\@biblabel{\@arabic\c@enumiv}}%
	{\settowidth\labelwidth{\@biblabel{#1}}%
		\leftmargin\labelwidth
		\advance\leftmargin\labelsep
		\itemsep \z@ \@plus\p@ \@minus\p@
		\@openbib@code
		\usecounter{enumiv}%
		\let\p@enumiv\@empty
		\renewcommand\theenumiv{\@arabic\c@enumiv}}%
	\sloppy
	\clubpenalty4000
	\@clubpenalty \clubpenalty
	\widowpenalty4000%
	\sfcode`\.\@m}
{\def\@noitemerr
	{\@latex@warning{Empty `thebibliography' environment}}%
	\endlist}

% 采用gbt7714-2005参考文献样式，
% 参考自https://github.com/githamburger/GBT7714-2005-BibTeX-Style
% \PassOptionsToPackage{backend=biber,style=gb7714-2015,gbnamefmt=lowercase,gbpub=false,gbpunctin=false}{biblatex}

% natbib宏包命令，参考文献上标设置。
\setcitestyle{super,square,comma}

% 重新定义 \ref 命令，使其前面自动加一个 ``~''。因为hyperref 宏包会通过 \AtBegin-
% Document 修改 \ref 的定义，因此我们对 \ref 的修改也必须使用\AtBeginDocument 命
% 令进行。同时我们需要修改 \eqref，使其括号前后不出现空隙。参考自njuthesis胡海星。
\AtBeginDocument{%
	\let\oldref\ref%
	\renewcommand*{\ref}[1]{\thinspace\oldref{#1}}%
	\renewcommand*{\eqref}[1]{(\oldref{#1})}
}

% ---------- 浮动体相关定义 ----------
% 设置浮动环境标题的字体大小。根据学位论文格式要求，插图和表格标题字体需要比正文
% 字体略小。
\captionsetup{%
	format=hang,
	labelsep=quad,		% 去掉图表号后的冒号。图序与图名文字之间空一个汉字宽度。
	skip=10pt,			% 标题与图标之间空10pt距离。
	font=small,			% 标题字体比正文小一号，这里取small。
	width=.75\textwidth % 标题最大宽度为0.75倍正文宽度。
}

\captionsetup[sub]{%
	font={small} % 子图同样使用宋体小号
}

\AtBeginEnvironment{tabular}{\songti\zihao{5}}
\AtBeginEnvironment{longtable}{\songti\zihao{5}}
\AtBeginEnvironment{tabu}{\songti\zihao{5}}

% 根据学位论文格式要求，表格的标题必须位于表格上方，插图的标题必须位于插图下方。
\captionsetup[table]{position=above}
\captionsetup[figure]{position=below}

%% 以下为设置浮动对象和文字之间的距离。
% 版心顶部或者版心底部浮动体之间的垂直距离，默认为12pt plus 2pt minus 2pt。
\setlength{\floatsep}{20bp \@plus4pt \@minus1pt}

% 文本行之间浮动体（使用h位置选项）与上下文之间的距离，默认为12pt plus 2pt minus
% 2pt。
\setlength{\intextsep}{20bp \@plus4pt \@minus2pt}

% 版心顶部或底部的浮动体与文本之间的距离，默认为12pt plus 2pt minus 2pt。
\setlength{\textfloatsep}{20bp \@plus4pt \@minus2pt}

% 浮动页中，版心顶部的浮动体与版心顶边之间的距离，默认为0pt plus 1fil。
\setlength{\@fptop}{0bp \@plus1.0fil}

% 浮动页中浮动体直接的距离，默认为8pt plus 2fil。
\setlength{\@fpsep}{12bp \@plus2.0fil}

% 浮动页中，版心底部的浮动体与版心底边之间的距离，默认为0pt plus 1fil。
\setlength{\@fpbot}{0bp \@plus1.0fil}

%% 下面这组命令使浮动对象的缺省值稍微宽松一点，从而防止幅度对象占据过多的文本页
%% 面，也可以防止在很大空白的浮动页上放置很小的图形。
% 默认情况下，LaTeX要求每页的文字至少占据 20%，否则该页就只单独放置一个浮动环境。
% 而这通常不是我们想要的。我们将这个要求降低到 5%。
\renewcommand{\textfraction}{0.05}

% 在一文本页中，被置于版心顶部的所有浮动体的高度与版心高度的最大比值，默认为0.7，
% 这里修改为0.9，任何造成高度超过版心高度90% 的浮动体都被将阻止置于当前版心顶部。
\renewcommand{\topfraction}{0.9}

% 同上，只不过变成了版心底部，默认为0.3.
\renewcommand{\bottomfraction}{0.8}

% 在任意一个“浮动页”中，所有的浮动体高度与版心的高度的最小比值，默认为 0.5，这里
% 设置成0.85。因此，浮动页中空白与版心的比值不会超过1-\floatpagefraction。
\renewcommand{\floatpagefraction}{0.85}

% ---------- 中英文摘要及关键词 ----------
% 中文摘要环境
\newenvironment{cabstract}{%
	\chapter{摘\texorpdfstring{\HDUspace}{}要}
}{}

\newenvironment{eabstract}{%
	\chapter{ABSTRACT}
}{}

% 中英文关键词命令及其格式的自动定义；
% 参照thuthesis，薛瑞尼，P37/66，v4.8.1 (2014/12/09)。
% 这段宏定义搞了我一个下午才看懂，哎…… 这个 \@for 命令挺有用的。
\def\HDU@parse@keywords#1{
	\expandafter\gdef\csname HDU@#1\endcsname{} % todo: need or not?
	\expandafter\gdef\csname @#1\endcsname##1{
		\@for\reserved@a:=##1\do{
			\expandafter\ifx\csname HDU@#1\endcsname\@empty\else
				\expandafter\g@addto@macro\csname HDU@#1\endcsname{%
					\ignorespaces\csname HDU@#1@separator\endcsname}
			\fi
			\expandafter\expandafter\expandafter\g@addto@macro%
			\expandafter\csname HDU@#1\expandafter\endcsname%
			\expandafter{\reserved@a}}}}

% 根据以上宏定义，以下命令分别产生\@ckeywords{} 和 \@ekeywords{} 两个读取关
% 键词的宏，和加工后保存关键词的 \HDU@ckeywords 和 \HDU@ckeywords 的宏定义。
\HDU@parse@keywords{ckeywords}
\HDU@parse@keywords{ekeywords}

% 杭电计算机学院要求用逗号分隔关键词
\def\HDU@ckeywords@separator{，}
\def\HDU@ekeywords@separator{,}


% 用户界面命令，读取和排版关键词
\newcommand*\ckeywords[1]{%
	\@ckeywords{#1}
	\vspace{5ex minus 4pt}
	%\noindent\textbf{关键词：}\HDU@ckeywords}
	\textbf{关键词：}\HDU@ckeywords}
\newcommand*\ekeywords[1]{%
	\@ekeywords{#1}
	\vspace{5ex}
	%\noindent\textbf{Keywords:}\ \HDU@ekeywords}
	\textbf{Keywords:}\ \HDU@ekeywords}

% ---------- 通用列表环境的重新定义 ----------
% 以下列表参数的修改主要是模仿book.cls，整体样式改动不大，只是修改了参数，但是去

%% 各级列表的缩进没有改变，所以注释掉了，如需改变，自己改。
% \setlength\leftmargini  {2.5em}
% \leftmargin\leftmargini
% \setlength\leftmarginii  {2.2em}
% \setlength\leftmarginiii {1.87em}
% \setlength\leftmarginiv  {1.7em}
% \setlength\leftmarginv  {1em}
% \setlength\leftmarginvi {1em}
%% 标签与列表正文的间距和标签的宽度，因为参数没改，所以注释掉了。
% \setlength  \labelsep  {.5em}
% \setlength  \labelwidth{\leftmargini}
% \addtolength\labelwidth{-\labelsep}

% 鼓励在list前、后和item间分页。
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty

% 各级列表的参数结构参数设置
\def\@listi{\leftmargin\leftmargini
	\parsep\parskip
	\topsep\z@
	\itemsep\z@}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
	\labelwidth\leftmarginii
	\advance\labelwidth-\labelsep
	\topsep \z@
	\parsep \z@
	\itemsep \parsep}
\def\@listiii{\leftmargin\leftmarginiii
	\labelwidth\leftmarginiii
	\advance\labelwidth-\labelsep
	\topsep \z@
	\parsep \z@
	\partopsep \p@ \@plus\z@ \@minus\p@
	\itemsep \topsep}
\def\@listiv {\leftmargin\leftmarginiv
	\labelwidth\leftmarginiv
	\advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
	\labelwidth\leftmarginv
	\advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
	\labelwidth\leftmarginvi
	\advance\labelwidth-\labelsep}

% ---------- 打算重新定义Enumerate，Itemize，先挖个坑 ----------


% ---------- 缩写、符号清单、术语表 ----------
% 以下尺寸详细说明见P33/112
\newenvironment*{denotation}[1][2.5cm]{
	\chapter{缩写、符号清单、术语表}
	\noindent
	\begin{list}{}{
			\renewcommand\makelabel[1]{##1\hfil}
			\setlength{\itemindent}{0cm} 			% 标签缩进量
			\setlength{\labelsep}{1cm} 				% 标签与列表文本距离
			\setlength{\labelwidth}{#1} 			% 标签盒子宽度，如有需要可以自行修改
			\setlength{\listparindent}{0pt} 		% 同一\item 第二及以后段落缩进量
			\setlength{\rightmargin}{0cm}
			\setlength{\leftmargin}{\labelwidth}		% list环境整体向右推
			\addtolength{\leftmargin}{\labelsep}		% \labelwidth + \labelsep 的距离
			\setlength{\itemsep}{0pt plus2pt minus1pt}	% 标签间距
			\setlength{\parsep}{\itemsep} 				% 段落间距
			\setlength{\topsep}{0pt} 					% 标签与上文的间距
			\setlength{\partopsep}{3pt plus2pt minus2pt}
		}}{\end{list}}

% ---------- 脚注样式 ----------
% 使用footmisc宏包和pifont宏包设置符合 GB/T 7713.1-2006 规范的脚注样式。注意，由
% 于pifont宏包提供的特殊符号的限制，一页之中最多只能有10个脚注。
% 这些命令设置跟脚注设置方法思路全都引用自南京大学计算机科学与技术系胡海星编写的
% 《NJU-Thesis:南京大学学位论文XeLaTeX模板》v1.1.18 (2015/7/16)版本。
\DefineFNsymbols*{circlednumber}[text]{%
	{\ding{192}} %
		{\ding{193}} %
		{\ding{194}} %
		{\ding{195}} %
		{\ding{196}} %
		{\ding{197}} %
		{\ding{198}} %
		{\ding{199}} %
		{\ding{200}} %
		{\ding{201}}}
\setfnsymbol{circlednumber}


\AtBeginDocument{
	\hypersetup{%
		pdftitle={\HDU@title},%
		pdfauthor={\HDU@author},%
		pdfkeywords={},%
		pdfcreator={Latex，ydar95}
	}
}

