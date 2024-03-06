\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{esdiploma}[06/03/2024 class for students VKR]

\def\my@baseclass{report}
\LoadClass[a4paper,12pt]{\my@baseclass}

% Note that the argument must be expandable,
% or use xkvltxp package before \documentclass (see manual of xkeyval)

\usepackage{fontspec}
\usepackage{CharisSIL}
\setmainfont{Charis SIL}
%\usepackage[russian]{babel}

\usepackage{polyglossia}
\setdefaultlanguage{russian}

\usepackage[a4paper, includefoot,
left=2.7cm, right=1.3cm, top=2cm, bottom=1cm, 
headsep=0.5cm, footskip=1cm
]{geometry}

\usepackage{setspace}
\setstretch{1.6}
\usepackage{indentfirst}
\setlength{\parindent}{2.25em}%Красная строка

\usepackage{caption}
\captionsetup[table]{font={stretch=1.2}}     %% change 1.2 as you like
\captionsetup[figure]{font={stretch=1.5}}    %% change 1.2 as you like

\usepackage{wasysym}
\usepackage{multirow}
\usepackage{longtable}

\usepackage{adjustbox}
\usepackage{float}
\floatplacement{figure}{H}
\usepackage{color}
\definecolor{green}{RGB}{1,200,100} %изменить "условный" цвет шрифта
\definecolor{lblue}{RGB}{33,150,209}

\usepackage{titlesec}
\titleformat{\chapter}[hang]
{\large\bfseries\filright}
{\MakeUppercase{\chaptertitlename}~\thechapter.}
{8pt}
{}

\titleformat{\section}
{\normalfont\bfseries}
{\thesection.}
{.5em}
{}
{}

\titleformat{\subsection}
{\normalfont\bfseries}
{\thesubsection.}
{.5em}
{}
{}        

\titlespacing{\chapter}{0pt}{1cm}{1cm}
\titlespacing{\paragraph}{0pt}{2ex}{0.3em}

\usepackage{chngcntr}
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter} 

\usepackage[square]{natbib}
\bibliographystyle{gost_style}
\makeatletter 
\renewcommand\NAT@biblabel[1]{[#1]} 
\newcommand{\citeg}[1]{\citep[e.g.,][]{#1}}

\usepackage{hyperref}%цвет гиперссылок + сами оглавление
\hypersetup{colorlinks=true, 
	citecolor=lblue,
	linkcolor=lblue, %цвет ссылки,
	filecolor=black,
	urlcolor=lblue, %что-то меняет цвет?
	%pdfpagemode=FullScreen
}

\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhf[ch]{\thepage}
\renewcommand\headrulewidth{0pt}
%\usepackage{etoolbox}
%\patchcmd{\chapter}{\thispagestyle{plain}}{\thispagestyle{fancy}}{}{}
%% если нужно номер страницы по госту -- в верхнем колонтитуле.
\fancypagestyle{plain}{% % <-- this is new
	\fancyhf{} 
	\fancyhf[ch]{\thepage}
	\renewcommand{\headrulewidth}{0pt}}


\usepackage{ifthen}

\usepackage[titletoc]{appendix}

%% Эта команда добавляет отчеркнутое место для подписи после имени
%% Аргументы: имя и пояснение под чертой (например, слово "подпись")
\def\sigspace{\\[3em]}
\newcommand\sigplace[2]{
#1\\[1.2em]
\underline{\hspace{3cm}}\\[-0.2em]
{\footnotesize #2}
\def\sigspace{\\[1em]%
\def\sigspace{\\[3em]}}
}
\renewcommand{\contentsname}{\large{ОГЛАВЛЕНИЕ}}
\def\chaptername{ГЛАВА}

\usepackage{tocloft}
\renewcommand{\cftchapfont}{\bfseries}
\renewcommand{\cftchappagefont}{\bfseries}
\renewcommand{\cftchappresnum}{ГЛАВА }
\renewcommand{\cftchapaftersnum}{.}
\renewcommand{\cftchapnumwidth}{5em}


%% нормальные математические шрифты, но нужно папку с гарнитурой поместить в корень
\usepackage{amsmath}
% \usepackage{unicode-math}
% \setmathfont{STIX2Math}[
% Extension={.otf},
% Path=./STIX2fonts/,
% Scale=1] 

%% Параметры заполнения титульного листа
\usepackage{xkeyval}

%% Русскоязычный вариант
\define@key[ru]{mytitle}{university}{\def\my@title@university{#1}}
\define@key[ru]{mytitle}{faculty}{\def\my@title@faculty{#1}}
\define@key[ru]{mytitle}{chair}{\def\my@title@chair{#1}}
\define@key[ru]{mytitle}{title}{\def\my@title@title{#1}}
\define@key[ru]{mytitle}{author}{\def\my@title@author{#1}}
\define@key[ru]{mytitle}{supervisor}{\def\my@title@supervisor{#1}}
\define@key[ru]{mytitle}{supervisorPosition}{\def\my@title@supervisorPosition{#1}}
\define@key[ru]{mytitle}{reviewer}{\def\my@title@reviewer{#1}}
\define@key[ru]{mytitle}{reviewerPosition}{\def\my@title@reviewerPosition{#1}}
\define@key[ru]{mytitle}{year}{\def\my@title@year{#1}}
\define@key[ru]{mytitle}{city}{\def\my@title@city{#1}}
\define@choicekey*[ru]{mytitle}{type}{diploma,coursework,master,bachelor}{\def\my@title@type{#1}}

\newcommand\filltitle[2]{
        \presetkeys[#1]{mytitle}{
          university = {Санкт-Петербургский государственный университет},
          faculty = {Институт наук о Земле},
          city = {Санкт-Петербург},
          year = {\the\year}
        }{}
    \setkeys[#1]{mytitle}{#2}
}

\newcommand\makemytitle{
\fancypagestyle{mytitle}{
    \fancyhf{}  % clear all header and footer fields
    \renewcommand{\headrulewidth}{0pt}  % remove head ruler
    %% В верхнем колонтитуле будет университет и кафедра
    \chead{\large \textsc{
      \my@title@university} \\
       \vskip 1em
      \ifthenelse{\equal{\normalsize  \my@title@faculty}{}}{}{\normalsize \my@title@faculty \\}  
      \vskip 1em
      {\normalsize \my@title@chair  \\}
    }
    %% В нижнем колонтитуле город и год
    \cfoot{\normalsize\parbox[b]{\textwidth}{\centering \my@title@city\\ \my@title@year}}
}

\title{\my@title@title}
\begin{titlepage}
\newgeometry{top=20mm,bottom=20mm,left=20mm,right=15mm,nohead,includeheadfoot}
\thispagestyle{mytitle}
\begin{center}
    \vspace*{0.30\textheight}
    {\normalsize \my@title@author}
    
    \vskip 2em
    {\large \bf \@title\\}
    
    \vskip 1em
    {\normalsize 
    \ifthenelse{\equal{\my@title@type}{coursework}}
    {Курсовая работа}
    {\ifthenelse{\equal{\my@title@type}{diploma}}
    {Дипломная работа}
    {\ifthenelse{\equal{\my@title@type}{master}}
    {Магистерская диссертация}
    {\ifthenelse{\equal{\my@title@type}{bachelor}}
    {Бакалаврская работа}
    }}}
    \\}
    \vskip 2em
    \ifthenelse{\equal{\my@title@type}{coursework}}
    {\normalsize \raggedleft 
    Научный руководитель:\\
    \my@title@supervisorPosition\ \my@title@supervisor
    }
    {\normalsize \raggedleft 
    \vskip 5em
    Научный руководитель:\\
    \my@title@supervisorPosition\ \my@title@supervisor\sigspace
    Рецензент:\\
    \my@title@reviewerPosition\ \my@title@reviewer
    }
\end{center}
\end{titlepage}
}

\renewcommand\maketitle{
\newcounter{titlepages}
\setcounter{titlepages}{1}
\begin{spacing}{1.15}
\ifthenelse{\isundefined{\my@title@title}}{}{
  \setlength{\headheight}{0pt}
  \setlength{\footskip}{0pt}
  \makemytitle\addtocounter{titlepages}{1}
}
\end{spacing}
\setcounter{page}{\value{titlepages}}
\restoregeometry
}

