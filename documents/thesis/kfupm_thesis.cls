%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% file name:     kfupm_thesis.cls
%% author:        
%% Modified by:   
%% release date:  
%%
%% KFUPM thesis template version 2.01 (March/05/2007) 
%% This template is based on standard LaTeX report class
%% and modified from ``report.cls'' file.
%%
%% This class is provided as is under GNU public license. 
%% For more information about GNU licensing visit and 
%% www.gnu.org
%%
%% For bugs, errors, ommisions, suggestions, and comments 
%% write to the author at shussain@ccse.kfupm.edu.sa
%%
%% 
%% Revision history: KFUPM thesis template version 2.02 (February/09/2016)
%%     DATE/TIME                 DESCRIPTION
%%    02/09/2016                 Revision is made in line with the Uniersity Library reviewing standard and   
%%                                       degree accomplish. (Muhammad A. Sulaiman 
%%                                                                 (DGS: muhalisu@kfupm.edu.sa)) 
%%    07/02/2018                Minor revision based on the feedback from students (MA Sulaiman)
%%.......................................................................................................................................  %%   
%%  Revision history:         KFUPM thesis template version 3.0  (June 04, 2018)
%%                            Major revision  made  by Dr. Waqas Afzal (waqas@kfupm.edu.sa or waqas4.afzal@gmail.com)
%%                            This version 3.0 addresses many issues including the  handling Arabic abstract, 
%%                            green card title page printing, double-sided printing and many more.
%%                                    
%% === ======================= = =========== ====================================
%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{kfupm_thesis}
[2007/03/18 v2.1
KFUPM MS/Ph.D. thesis/dissertation template.]
\usepackage{setspace}                   % package required to change spacing
\usepackage{ifthen}                     % for conditional programming
%%---------------------------------------------------------
%Package removed and glossaries used instead
%----------------------------------------------------------
%\usepackage[compatible]{nomencl}

% new variables
\def\dept#1{\def\dept{#1}}
\def\major#1{\def\major{#1}}
\def\program#1{\def\program{#1}}
\def\adviser#1{\def\adviser{#1}}
%------------------------------
%
%------------------------------
%for coadviser
\def\coadviser#1{\def\coadviser{#1}}
\let\testcoadviser\coadviser%To check if a coadviser is available or not
%-----------------------------------
\def\memberone#1{\def\memberone{#1}}
\def\membertwo#1{\def\membertwo{#1}}
\def\memberthree#1{\def\memberthree{#1}}
\def\memberfour#1{\def\memberfour{#1}}
\def\chairman#1{\def\chairman{#1}}
\def\deanGS#1{\def\deanGS{#1}}
\def\DTC#1{\def\DTC{#1}}
%--------------------------------------
%
%--------------------------------------
%%added to get consistent use of thesis or dissertation
\def\reportname#1{\def\reportname{#1}}%
\def\Reportname#1{\def\Reportname{#1}}%
%--------------------------------------
%
%--------------------------------------
% variables for arabic abstract
\def\arname#1{\def\arname{#1}}
\def\artitle#1{\def\artitle{#1}}
\def\ardept#1{\def\ardept{#1}}
\def\ardate#1{\def\ardate{#1}}

%\def\ARNAME#1{\def\ARNAME{#1}}
%\def\ARTITLE#1{\def\ARTITLE{#1}}
%\def\ARDEPT#1{\def\ARDEPT{#1}}
%\def\ARDATE#1{\def\ARDATE{#1}}
%\def\ARABS#1{\def\ARABS{#1}}
%\def\ARPHD#1{\def\ARPHD{#1}}

%% 
%% The following part has been copied from IEEEtran.sty

%% CITATION AND BIBLIOGRAPHY COMMANDS
%%
%% V1.6 no longer supports the older, nonstandard \shortcite and \citename setup stuff
%
%
% Modify Latex2e \@citex to separate citations with "], ["
\def\@citex[#1]#2{%
	\let\@citea\@empty
	\@cite{\@for\@citeb:=#2\do
		{\@citea\def\@citea{], [}%
			\edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
			\if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
			\@ifundefined{b@\@citeb}{\mbox{\reset@font\bfseries ?}%
				\G@refundefinedtrue
				\@latex@warning
				{Citation `\@citeb' on page \thepage \space undefined}}%
			{\hbox{\csname b@\@citeb\endcsname}}}}{#1}}

% V1.6 we create hooks for the optional use of Donald Arseneau's
% cite.sty package. cite.sty is "smart" and will notice that the
% following format controls are already defined and will not
% redefine them. The result will be the proper sorting of the
% citation numbers and auto detection of 3 or more entry "ranges" -
% all in IEEE style:  [1], [2], [5]--[7], [12]
% This also allows for an optional note, i.e., \cite[mynote]{..}.
% If the \cite with note has more than one reference, the note will
% be applied to the last of the listed references. It is generally
% desired that if a note is given, only one reference is listed in
% that \cite.
% Thanks to Mr. Arseneau for providing the required format arguments
% to produce the IEEE style.
\def\citepunct{], [}
\def\citedash{]--[}

%
% Warning and Error messages
% 
% 
\newcommand\paperwarning{%
	\typeout{Only letter-sized paper allowed: Use`letterpaper' option instead}%
	\@latex@warning{Incorrect paper size option set.}}

\newcommand\columnwarning{%
	\typeout{Only one column output allowed.}%
	\@latex@warning{Double-column not allowed.}}

% paper size preset to lattersize
% 
\setlength\paperheight {11in}%
\setlength\paperwidth  {8.5in}

\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagetrue
\newif\if@openright
\if@compatibility\else
\DeclareOption{a4paper}
{\paperwarning}
\DeclareOption{a5paper}
{\paperwarning}
\DeclareOption{b5paper}
{\paperwarning}
\DeclareOption{letterpaper}
{\setlength\paperheight {11in}%
	\setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
{\paperwarning}
\DeclareOption{executivepaper}
{\paperwarning}
\DeclareOption{landscape}
{\paperwarning}
\fi
\if@compatibility
\renewcommand\@ptsize{0}
\else
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\fi
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\if@compatibility\else
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\fi
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\if@compatibility\else
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\fi
\DeclareOption{titlepage}{\@titlepagetrue}
\if@compatibility\else
\DeclareOption{notitlepage}{\@titlepagefalse}
\fi
\if@compatibility
\else
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\fi
\if@compatibility\else
\DeclareOption{onecolumn}{\@twocolumnfalse}
\fi
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{%
	\AtEndOfPackage{%
		\renewcommand\@openbib@code{%
			\advance\leftmargin\bibindent
			\itemindent -\bibindent
			\listparindent \itemindent
			\parsep \z@
		}%
		\renewcommand\newblock{\par}}%
}
%---------------------------------------------
%
%---------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % This part changes the format of the title page to get the final print on the card provided by dgs.
% This option will be used to check if the Thesis/Disseratation is ready to print
\newif\ifDraft@PrintReady
\Draft@PrintReadyfalse %it is always false unless PrintReady option is given
\DeclareOption{printready}{%
	\Draft@PrintReadytrue
}%
%The following is used to make the committee composition of MS or PhD
\newif\ifDraft@MS
\Draft@MStrue %it is always true unless phd option is selected
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------
%
%--------------------------------------
%This gives consistent usage thesis and dissertation
\DeclareOption{ms}{%
	\program{MASTER OF SCIENCE}
	\DTC{Thesis Committee}
	\reportname{thesis}%
	\Reportname{Thesis}
	%For committee sign page purpose
	\Draft@MStrue
}
\DeclareOption{phd}{%
	\program{DOCTOR OF PHILOSOPHY}
	\DTC{Dissertation Committee}
	\reportname{dissertation}%
	\Reportname{Dissertation}
	%For committee sign page purpose
	\Draft@MSfalse
}

\ExecuteOptions{letterpaper,10pt,oneside,onecolumn,final,openany}
\ProcessOptions
\input{size1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength\parskip{0\p@ \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.3}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
\if@twoside
\def\ps@headings{%
	\let\@oddfoot\@empty\let\@evenfoot\@empty
	\def\@evenhead{\thepage\hfil\slshape\leftmark}%
	\def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
	\let\@mkboth\markboth
	\def\chaptermark##1{%
		\markboth {\MakeUppercase{%
				\ifnum \c@secnumdepth >\m@ne
				\@chapapp\ \thechapter. \ %
				\fi
				##1}}{}}%
	\def\sectionmark##1{%
		\markright {\MakeUppercase{%
				\ifnum \c@secnumdepth >\z@
				\thesection. \ %
				\fi
				##1}}}}
\else
\def\ps@headings{%
	\let\@oddfoot\@empty
	\def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
	\let\@mkboth\markboth
	\def\chaptermark##1{%
		\markright {\MakeUppercase{%
				\ifnum \c@secnumdepth >\m@ne
				\@chapapp\ \thechapter. \ %
				\fi
				##1}}}}
\fi
\def\ps@myheadings{%
	\let\@oddfoot\@empty\let\@evenfoot\@empty
	\def\@evenhead{\thepage\hfil\slshape\leftmark}%
	\def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
	\let\@mkboth\@gobbletwo
	\let\chaptermark\@gobble
	\let\sectionmark\@gobble
}
\if@titlepage
\newcommand\maketitle{\begin{titlepage}%
		\let\footnotesize\small
		\let\footnoterule\relax
		\let \footnote \thanks
		\null\vfil
		\vskip 60\p@
		\begin{center}%
			{\LARGE \@title \par}%
			\vskip 3em%
			{\large
				\lineskip .75em%
				\begin{tabular}[t]{c}%
					\@author
				\end{tabular}\par}%
			\vskip 1.5em%
			{\large \@date \par}%       % Set date in \large size.
		\end{center}\par
		\@thanks
		\vfil\null
	\end{titlepage}%
	\setcounter{footnote}{0}%
	\global\let\thanks\relax
	\global\let\maketitle\relax
	\global\let\@thanks\@empty
	\global\let\@author\@empty
	\global\let\@date\@empty
	\global\let\@title\@empty
	\global\let\title\relax
	\global\let\author\relax
	\global\let\date\relax
	\global\let\and\relax
}
\else
\newcommand\maketitle{\par
	\begingroup
	\renewcommand\thefootnote{\@fnsymbol\c@footnote}%
	\def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
	\long\def\@makefntext##1{\parindent 1em\noindent
		\hb@xt@1.8em{%
			\hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
	\if@twocolumn
	\ifnum \col@number=\@ne
	\@maketitle
	\else
	\twocolumn[\@maketitle]%
	\fi
	\else
	\newpage
	\global\@topnum\z@   % Prevents figures from going at top of page.
	\@maketitle
	\fi
	\thispagestyle{plain}\@thanks
	\endgroup
	\setcounter{footnote}{0}%
	\global\let\thanks\relax
	\global\let\maketitle\relax
	\global\let\@maketitle\relax
	\global\let\@thanks\@empty
	\global\let\@author\@empty
	\global\let\@date\@empty
	\global\let\@title\@empty
	\global\let\title\relax
	\global\let\author\relax
	\global\let\date\relax
	\global\let\and\relax
}
\def\@maketitle{%
	\newpage
	\null
	\vskip 2em%
	\begin{center}%
		\let \footnote \thanks
		{\LARGE \@title \par}%
		\vskip 1.5em%
		{\large
			\lineskip .5em%
			\begin{tabular}[t]{c}%
				\@author
			\end{tabular}\par}%
		\vskip 1em%
		{\large \@date}%
	\end{center}%
	\par
	\vskip 1.5em}
\fi
\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{2}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand \thepart {\@Roman\c@part}
\renewcommand \thechapter {\@arabic\c@chapter}
\renewcommand \thesection {\thechapter.\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\@chapapp{\chaptername}
\newcommand\part{%
	\if@openright
	\cleardoublepage
	\else
	\clearpage
	\fi
	\thispagestyle{plain}%
	\if@twocolumn
	\onecolumn
	\@tempswatrue
	\else
	\@tempswafalse
	\fi
	\null\vfil
	\secdef\@part\@spart}

\def\@part[#1]#2{%
	\ifnum \c@secnumdepth >-2\relax
	\refstepcounter{part}%
	\addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
	\else
	\addcontentsline{toc}{part}{#1}%
	\fi
	\markboth{}{}%
	{\centering
		\interlinepenalty \@M
		\normalfont
		\ifnum \c@secnumdepth >-2\relax
		\huge\bfseries \partname\nobreakspace\thepart
		\par
		\vskip 20\p@
		\fi
		\Huge \bfseries #2\par}%
	\@endpart}
\def\@spart#1{%
	{\centering
		\interlinepenalty \@M
		\normalfont
		\Huge \bfseries #1\par}%
	\@endpart}
\def\@endpart{\vfil\newpage
	\if@twoside
	\if@openright
	\null
	\thispagestyle{empty}%
	\newpage
	\fi
	\fi
	\if@tempswa
	\twocolumn
	\fi}
\newcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
	\thispagestyle{plain}%
	\global\@topnum\z@
	\@afterindentfalse
	\secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
	\refstepcounter{chapter}%
	\typeout{\@chapapp\space\thechapter.}%
	\addcontentsline{toc}{chapter}%
	{ %
		%-----------------------------------
		%
		%-----------------------------------
		\texorpdfstring\MakeUppercase{}{\@chapapp\space}%
		\numberline{\thechapter}%
		\texorpdfstring\MakeUppercase{}{#1}%
		%\protect {CHAPTER }\numberline{\thechapter}\MakeUppercase{#1} %
	}%
	\else
	\addcontentsline{toc}{chapter}{\MakeUppercase{#1}}%
	\fi
	\chaptermark{#1}%
	\addtocontents{lof}{\protect\addvspace{10\p@}}%
	\addtocontents{lot}{\protect\addvspace{10\p@}}%
	\if@twocolumn
	\@topnewpage[\@makechapterhead{#2}]%
	\else
	\@makechapterhead{#2}%
	\@afterheading
	\fi}
\def\@makechapterhead#1{%
	\vspace*{50\p@}%
	{\parindent \z@ \raggedright \normalfont
		\ifnum \c@secnumdepth >\m@ne
		\centering \Large \bfseries \MakeUppercase{\@chapapp}\space \thechapter 
		\par\nobreak
		\vskip 20\p@
		\fi
		\interlinepenalty\@M
		\Huge \bfseries \MakeUppercase{#1}\par\nobreak
		\vskip 40\p@
}}
\def\@schapter#1{\if@twocolumn
	\@topnewpage[\@makeschapterhead{#1}]%
	\else
	\@makeschapterhead{#1}%
	\@afterheading
	\fi}
\def\@makeschapterhead#1{%
	\vspace*{50\p@}%
	{\parindent \z@ \raggedright
		\normalfont
		\interlinepenalty\@M
		\Huge \bfseries  #1\par\nobreak
		\vskip 40\p@
}}
\newcommand\section{\@startsection {section}{1}{\z@}%
	{-3.5ex \@plus -1ex \@minus -.2ex}%
	{2.3ex \@plus.2ex}%
	{\normalfont\Large\bfseries}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
	{-3.25ex\@plus -1ex \@minus -.2ex}%
	{1.5ex \@plus .2ex}%
	{\normalfont\large\bfseries}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
	{-3.25ex\@plus -1ex \@minus -.2ex}%
	{1.5ex \@plus .2ex}%
	{\normalfont\normalsize\bfseries}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
	{3.25ex \@plus1ex \@minus.2ex}%
	{-1em}%
	{\normalfont\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
	{3.25ex \@plus1ex \@minus .2ex}%
	{-1em}%
	{\normalfont\normalsize\bfseries}}
\if@twocolumn
\setlength\leftmargini  {2em}
\else
\setlength\leftmargini  {2.5em}
\fi
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
\setlength\leftmarginv  {.5em}
\setlength\leftmarginvi {.5em}
\else
\setlength\leftmarginv  {1em}
\setlength\leftmarginvi {1em}
\fi
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\textbullet}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textasteriskcentered}
\newcommand\labelitemiv{\textperiodcentered}
\newenvironment{description}
{\list{}{\labelwidth\z@ \itemindent-\leftmargin
		\let\makelabel\descriptionlabel}}
{\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
	\normalfont\bfseries #1}
\if@titlepage
\newenvironment{abstract}{%
	\titlepage
	\null\vfil
	\@beginparpenalty\@lowpenalty
	\begin{center}%
		\bfseries \abstractname
		\@endparpenalty\@M
\end{center}}%
{\par\vfil\null\endtitlepage}
\else
\newenvironment{abstract}{%
	\if@twocolumn
	\section*{\abstractname}%
	\else
	\small
	\begin{center}%
		{\bfseries \abstractname\vspace{-.5em}\vspace{\z@}}%
	\end{center}%
	\quotation
	\fi}
{\if@twocolumn\else\endquotation\fi}
\fi
\newenvironment{verse}
{\let\\\@centercr
	\list{}{\itemsep      \z@
		\itemindent   -1.5em%
		\listparindent\itemindent
		\rightmargin  \leftmargin
		\advance\leftmargin 1.5em}%
	\item\relax}
{\endlist}
\newenvironment{quotation}
{\list{}{\listparindent 1.5em%
		\itemindent    \listparindent
		\rightmargin   \leftmargin
		\parsep        \z@ \@plus\p@}%
	\item\relax}
{\endlist}
\newenvironment{quote}
{\list{}{\rightmargin\leftmargin}%
	\item\relax}
{\endlist}
\if@compatibility
\newenvironment{titlepage}
{%
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse\newpage
	\fi
	\thispagestyle{empty}%
	\setcounter{page}\z@
}%
{\if@restonecol\twocolumn \else \newpage \fi
}
\else
\newenvironment{titlepage}
{%
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse\newpage
	\fi
	\thispagestyle{empty}%
	\setcounter{page}\@ne
}%
{\if@restonecol\twocolumn \else \newpage \fi
	\if@twoside\else
	\setcounter{page}\@ne
	\fi
}
\fi
\newcommand\appendix{\par
	\setcounter{chapter}{0}%
	\setcounter{section}{0}%
	\gdef\@chapapp{\appendixname}%
	\gdef\thechapter{\@Alph\c@chapter}}%
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset {equation}{chapter}
\renewcommand\theequation
{\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@equation}
\newcounter{figure}[chapter]
\renewcommand \thefigure
{\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename\nobreakspace\thefigure}
\newenvironment{figure}
{\@float{figure}}
{\end@float}
\newenvironment{figure*}
{\@dblfloat{figure}}
{\end@dblfloat}
\newcounter{table}[chapter]
\renewcommand \thetable
{\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename\nobreakspace\thetable}
\newenvironment{table}
{\@float{table}}
{\end@float}
\newenvironment{table*}
{\@dblfloat{table}}
{\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
	\vskip\abovecaptionskip
	\sbox\@tempboxa{#1: #2}%
	\ifdim \wd\@tempboxa >\hsize
	#1: #2\par
	\else
	\global \@minipagefalse
	\hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
	\fi
	\vskip\belowcaptionskip}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	\chapter*{\centerline{TABLE OF CONTENTS}
		\@mkboth{%
			\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
	\@starttoc{toc}%
	\if@restonecol\twocolumn\fi
}
\newcommand*\l@part[2]{%
	\ifnum \c@tocdepth >-2\relax
	\addpenalty{-\@highpenalty}%
	\addvspace{2.25em \@plus\p@}%
	\setlength\@tempdima{3em}%
	\begingroup
	\parindent \z@ \rightskip \@pnumwidth
	\parfillskip -\@pnumwidth
	{\leavevmode
		\large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
	\nobreak
	\global\@nobreaktrue
	\everypar{\global\@nobreakfalse\everypar{}}%
	\endgroup
	\fi}
\newcommand*\l@chapter[2]{%
	\ifnum \c@tocdepth >\m@ne
	\addpenalty{-\@highpenalty}%
	\vskip 1.0em \@plus\p@
	\setlength\@tempdima{1.5em}%
	\begingroup
	\parindent \z@ \rightskip \@pnumwidth
	\parfillskip -\@pnumwidth
	\leavevmode \bfseries
	\advance\leftskip\@tempdima
	\hskip -\leftskip
	#1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
	\penalty\@highpenalty
	\endgroup
	\fi}
\newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{12em}{6em}}
\newcommand\listoffigures{%
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	\chapter*{\centerline{\MakeUppercase\listfigurename}}%
	\@mkboth{\MakeUppercase\listfigurename}%
	{\MakeUppercase\listfigurename}%
	\@starttoc{lof}%
	\if@restonecol\twocolumn\fi
}
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
	\if@twocolumn
	\@restonecoltrue\onecolumn
	\else
	\@restonecolfalse
	\fi
	\chapter*{\centerline{\MakeUppercase\listtablename}}%
	\@mkboth{%
		\MakeUppercase\listtablename}%
	{\MakeUppercase\listtablename}%
	\@starttoc{lot}%
	\if@restonecol\twocolumn\fi
}
\let\l@table\l@figure
\newdimen\bibindent
\setlength\bibindent{1.5em}
\newenvironment{thebibliography}[1]
{\chapter*{\centering\bibname}%
	\@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
	\list{\@biblabel{\@arabic\c@enumiv}}%
	{\settowidth\labelwidth{\@biblabel{#1}}%
		\leftmargin\labelwidth
		\advance\leftmargin\labelsep
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
\newcommand\newblock{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty
\newenvironment{theindex}
{\if@twocolumn
	\@restonecolfalse
	\else
	\@restonecoltrue
	\fi
	\twocolumn[\@makeschapterhead{\indexname}]%
	\@mkboth{\MakeUppercase\indexname}%
	{\MakeUppercase\indexname}%
	\thispagestyle{plain}\parindent\z@
	\parskip\z@ \@plus .3\p@\relax
	\columnseprule \z@
	\columnsep 35\p@
	\let\item\@idxitem}
{\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\@idxitem \hspace*{20\p@}}
\newcommand\subsubitem{\@idxitem \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
	\kern-3\p@
	\hrule\@width.4\columnwidth
	\kern2.6\p@}
\@addtoreset{footnote}{chapter}
\newcommand\@makefntext[1]{%
	\parindent 1em%
	\noindent
	\hb@xt@1.8em{\hss\@makefnmark}#1}
\newcommand\contentsname{TABLE OF CONTENTS}
\newcommand\listfigurename{LIST OF FIGURES}
\newcommand\listtablename{LIST OF TABLES}
\newcommand\bibname{REFERENCES}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{CHAPTER}
\newcommand\appendixname{APPENDIX}
\newcommand\abstractname{ABSTRACT}
\def\today{\ifcase\month\or                  % 
	JANUARY\or FEBRUARY\or MARCH\or APRIL\or MAY\or JUNE\or
	JULY\or AUGUST\or SEPTEMBER\or OCTOBER\or NOVEMBER\or DECEMBER\fi
	\space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{plain}
\pagenumbering{arabic}
\if@twoside
\else
\raggedbottom
\fi
\if@twocolumn
\twocolumn
\sloppy
\flushbottom
\else
\onecolumn
\fi



%% modified and new code, 

%% 
%% title page according to kfupm style manual
\renewcommand\maketitle{%
	%----------------------------------
	%
	%----------------------------------
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%Checking for option of printready in document
	%waqas added to have consistent page numbering
	\pagenumbering{roman} %
	\ifDraft@PrintReady%
	\newgeometry{top=4cm, %4cm
		left=3.65cm, %3.65cm
		right=3.55cm, %3.55cm
		bottom=3.4cm} %3.4cm
	
	%changing margins to fit the vertical spacing on DGS Thesis/Dissertation card
	%\let\myfbsep\fboxsep%
	%\setlength{\fboxsep}{0pt}
	%\begin{titlepage} %
	\setstretch{1}
	\thispagestyle{empty}
	\let\footnotesize\small
	\let\footnoterule\relax
	\let \footnote \thanks
	{%
		\begin{center}%
			\begin{minipage}[][4.4cm][c]{\linewidth}%
				\centering\LARGE\bf
				\MakeUppercase{\@title}%
			\end{minipage}\par%
			\vspace{3.5mm}
			\begin{minipage}[][2.15cm][c]{\linewidth}%
				\centering\Large \bf \MakeUppercase{\@author}
			\end{minipage}\par%
			\vspace{9.1cm}  
			{\Large \bf \MakeUppercase\dept\par}
			\vfill
			{\Large \MakeUppercase\@date\par}
		\end{center}
	}%
	%\end{titlepage} %	
	\setcounter{footnote}{0}%
	\newgeometry{top    = 2.5cm,%
		left   = 3.75cm,%
		right  = 2.5cm,%
		bottom = 2.6cm}
	\else%
	%Normal title page used to submit to committee for defense
	\setstretch{1}
	\thispagestyle{empty}
	\let\footnotesize\small
	\let\footnoterule\relax
	\let \footnote \thanks
	\null\vfil
	\vskip 60\p@
	\begin{center}
		{\LARGE \MakeUppercase{\@title}\par}%
		\vspace{3em}
		{\Large BY\par}
		\vspace{1em}
		{\Large \bf \MakeUppercase{\@author} \par}%
		\vspace{6em}
		{\large A \Reportname{} Presented to the\par
			DEANSHIP OF GRADUATE STUDIES\par}%
		\vspace{3em}
		{\large In Partial Fulfillment of the Requirements\par
			for the Degree of\par}
		\vfill
		{\large \bf \program\par}
		\vspace{1.1em}
		{\large \bf IN\par}
		\vspace{1.1em}  
		{\large \bf \MakeUppercase\dept\par}
		\vfill
		{\Large KING FAHD UNIVERSITY\par
			OF PETROLEUM \& MINERALS\par}
		\vspace{1em}
		{\large Dhahran, Saudi Arabia\par}
		\vspace{1.5em}
		{\large \MakeUppercase\@date\par}
		\vfil\null%
	\end{center}%	
	\setcounter{footnote}{0}%
	\newgeometry{top    = 2.5cm,%
		left   = 3.75cm,%
		right  = 2.5cm,%
		bottom = 2.6cm}
	\fi%
}

%------------------------------------------
%
%------------------------------------------
%certificate page for committee members
\newcommand{\MakeCommitteeCertificate}{%
	\eject%
	\setstretch{1.2}%
	\thispagestyle{empty}%
	\begin{center}%
		{\large KING FAHD UNIVERSITY OF PETROLEUM \& MINERALS\par}
		\vspace{.1em}
		{DHAHRAN 31261, SAUDI ARABIA\par}
		\vspace{2em}
		{\large DEANSHIP OF GRADUATE STUDIES\par}%
	\end{center}%
	\sloppy This \reportname{}, written by {\bf \MakeUppercase{\@author}} under the direction of his \reportname{} adviser and approved by his \reportname{} committee, has been presented to and accepted by the Dean of Graduate Studies, in partial fulfillment of the requirements for the degree of {\bf \MakeUppercase{\program}\ IN \MakeUppercase{\dept}}.\par%
	\vfill%
	\noindent%
	\ifx\coadviser\testcoadviser%
	\ifDraft@MS%	
	\begin{tabular}{p{0.33\linewidth}p{0.063\linewidth}p{0.52\linewidth}}
		& & {\bf \underline{\DTC}} \\\vspace{20pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \adviser\ (Adviser)\\\vspace{12pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberone\ (Member) \\\vspace{12pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \membertwo\ (Member) \\\vspace{12pt}
		& & \\\cline{1-1}%\vspace{2pt}
		\chairman & & \\
		Department Chairman & & \\\vspace{12pt}
		& & \\\cline{1-1}%\vspace{2pt}
		\deanGS & & \\
		Dean of Graduate Studies & &\\\vspace{12pt}
		& & \\\cline{1-1}%\vspace{2pt}
		Date & &
	\end{tabular}
	\else%
	\begin{tabular}{p{0.33\linewidth}p{0.063\linewidth}p{0.52\linewidth}}
		& & {\bf\underline{\DTC}} \\[20pt] %\vspace{18pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \adviser\ (Adviser)\\[12pt] %\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberone\ (Member) \\[12pt]%\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \membertwo\ (Member) \\[12pt]%\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberthree\ (Member) \\[12pt]%\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberfour\ (Member)\\[12pt]%\vspace{10pt}
		& & \\\cline{1-1}%\vspace{2pt}
		\chairman & & \\
		Department Chairman & & \\[12pt]%\vspace{10pt}
		& & \\\cline{1-1}%\vspace{2pt}
		\deanGS & & \\
		Dean of Graduate Studies & &\\[12pt]%\vspace{10pt}
		& & \\\cline{1-1}%\vspace{2pt}
		Date & &
	\end{tabular}
	\fi%
	\else%
	\begin{tabular}{p{0.33\linewidth}p{0.063\linewidth}p{0.52\linewidth}}
		& & {\bf\underline{\DTC}} \\[20pt] %\vspace{18pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \adviser\ (Adviser)\\[12pt] %\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberone\ (Co-Adviser) \\[12pt]%\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \membertwo\ (Member) \\[12pt]%\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberthree\ (Member) \\[12pt]%\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberfour\ (Member)\\[12pt]%\vspace{10pt}
		& & \\\cline{1-1}%\vspace{2pt}
		\chairman & & \\
		Department Chairman & & \\[12pt]%\vspace{10pt}
		& & \\\cline{1-1}%\vspace{2pt}
		\deanGS & & \\
		Dean of Graduate Studies & &\\[12pt]%\vspace{10pt}
		& & \\\cline{1-1}%\vspace{2pt}
		Date & &
	\end{tabular}
	\fi%
	\eject%
}%
%------------------------------------------------
% certificate page for three members committee
\newcommand{\MakeCertificateThree}{%
	\eject
	\setstretch{1.2}
	\thispagestyle{empty}
	\begin{center}
		{\large KING FAHD UNIVERSITY OF PETROLEUM \& MINERALS\par}
		\vspace{.1em}
		{DHAHRAN 31261, SAUDI ARABIA\par}
		\vspace{2em}
		{\large DEANSHIP OF GRADUATE STUDIES\par}
	\end{center}
	\sloppy This \reportname{}, written by {\bf \MakeUppercase{\@author}} under the direction of his \reportname{} adviser and approved by his \reportname{} committee, has been presented to and accepted by the Dean of Graduate Studies, in partial fulfillment of the requirements for the degree of {\bf \MakeUppercase{\program}\ IN \MakeUppercase{\dept}}.\par
	\vfill
	\noindent
	\begin{tabular}{p{0.39\textwidth}p{0.05\textwidth}p{0.46\textwidth}}
		& & {\bf \underline{\DTC}} \\\vspace{18pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \adviser\ (Adviser)\\\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberone\ (Member) \\\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \membertwo\ (Member) \\\vspace{10pt}
		& & \\\cline{1-1}%\vspace{2pt}
		\chairman & & \\
		Department Chairman & & \\\vspace{10pt}
		& & \\\cline{1-1}%\vspace{2pt}
		\deanGS & & \\
		Dean of Graduate Studies & &\\\vspace{10pt}
		& & \\\cline{1-1}%\vspace{2pt}
		Date & &
	\end{tabular}
	\eject
}

%Changed by Waqas to get automatically change composition if co advisor is available.
% certificate page for five members committee
\newcommand{\MakeCertificateFive}{%
	\eject
	\setstretch{1.2}
	\thispagestyle{empty}
	\renewcommand{\baselinestretch}{1.2}
	\begin{center}
		{\large KING FAHD UNIVERSITY OF PETROLEUM \& MINERALS\par}
		\vspace{.1em}
		{DHAHRAN 31261, SAUDI ARABIA\par}
		\vspace{2em}
		{\large DEANSHIP OF GRADUATE STUDIES\par}
	\end{center}
	\sloppy This \reportname{}, written by {\bf \MakeUppercase{\@author}} under the direction of his \reportname{} adviser and approved by his \reportname{} committee, has been presented to and accepted by the Dean of Graduate Studies, in partial fulfillment of the requirements for the degree of {\bf \MakeUppercase{\program}\ IN \MakeUppercase{\dept}}.\par
	\vfill
	\noindent
	%Automatically select different composition if committee has a Co-Adviser
	\if\coadviser\empty
	\begin{tabular}{p{0.33\linewidth}p{0.063\linewidth}p{0.52\linewidth}}
		& & {\bf\underline{\DTC}} \\[20pt] %\vspace{18pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \adviser\ (Adviser)\\[12pt] %\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberone\ (Member) \\[12pt]%\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \membertwo\ (Member) \\[12pt]%\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberthree\ (Member) \\[12pt]%\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberfour\ (Member)\\[12pt]%\vspace{10pt}
		%\end{tabular}
		%\vfil
		%\noindent
		%\begin{tabular}{p{0.33\linewidth}p{0.063\linewidth}p{0.52\linewidth}}
		& & \\\cline{1-1}%\vspace{2pt}
		\chairman & & \\
		Department Chairman & & \\[12pt]%\vspace{10pt}
		& & \\\cline{1-1}%\vspace{2pt}
		\deanGS & & \\
		Dean of Graduate Studies & &\\[12pt]%\vspace{10pt}
		& & \\\cline{1-1}%\vspace{2pt}
		Date & &
	\end{tabular}
	\else
	\begin{tabular}{p{0.33\linewidth}p{0.063\linewidth}p{0.52\linewidth}}
		& & {\bf\underline{\DTC}} \\[20pt] %\vspace{18pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \adviser\ (Adviser)\\[12pt] %\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberone\ (Co-Adviser) \\[12pt]%\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \membertwo\ (Member) \\[12pt]%\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberthree\ (Member) \\[12pt]%\vspace{10pt}
		& & \\ \cline{3 - 3}\vspace{2pt}
		& & \memberfour\ (Member)\\[12pt]%\vspace{10pt}
		%\end{tabular}
		%\vfil
		%\noindent
		%\begin{tabular}{p{0.33\linewidth}p{0.063\linewidth}p{0.52\linewidth}}
		& & \\\cline{1-1}%\vspace{2pt}
		\chairman & & \\
		Department Chairman & & \\[12pt]%\vspace{10pt}
		& & \\\cline{1-1}%\vspace{2pt}
		\deanGS & & \\
		Dean of Graduate Studies & &\\[12pt]%\vspace{10pt}
		& & \\\cline{1-1}%\vspace{2pt}
		Date & &
	\end{tabular}
	\fi
	\eject
}

% Theorem like definitions
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{lemma}{Lemma}[chapter]
\newtheorem{definition}{Definition}[chapter]
\newtheorem{claim}{Claim}[chapter]
\newtheorem{proposition}{Proposition}[chapter]

% new proof environment for typesetting proofs
% re-define \QED to produce different box at the end of the proof
\newcommand{\QED}{\rule{3pt}{1em}}
\newenvironment{proof}[1]{%
	\begin{sloppypar}\noindent\textbf{Proof. } #1}{%
		\hspace*{\fill}\QED\end{sloppypar}}



\newcommand{\Acknowledgements}[1]{%
	%-----------------------------------
	%
	%-----------------------------------
	\phantomsection % This ensures correct page numbering in the table of contents
	\addcontentsline{toc}{chapter}{ACKNOWLEDGMENTS} %Add ACKNOWLEDGMENTS to the table of contents as a clickable link with hyperref package
	%\addtocontents{toc}{\contentsline {chapter}{\numberline {}ACKNOWLEDGMENTS}{\pageref{ack}}}
	\label{ack}
	\chapter*{\centering ACKNOWLEDGMENTS}
	\vspace*{-1em}
	\setstretch{2}
	\noindent #1
	
	\eject
}


\newcommand{\Abstract}[1]{%
	%-----------------------------------
	%
	%-----------------------------------
	\phantomsection % This ensures correct page numbering in the table of contents
	\addcontentsline{toc}{chapter}{ABSTRACT (ENGLISH)}%Add ABSTRACT (ENGLISH) to the table of contents as a clickable link with hyperref package
	\label{abstractEnglish}%
	%\addtocontents{toc}{\contentsline {chapter}{\numberline {}ABSTRACT (ENGLISH)}{\pageref{abstractEnglish}}}
	%\label{abstractEnglish}
	%\centerline{\bf \LARGE THESIS ABSTRACT}\par\vspace{2em}
	\chapter*{\centering \MakeUppercase{\Reportname} ABSTRACT}
	
	\vspace*{-1em}
	\noindent
	\begin{tabular}{lp{10.3cm}}
		{\bf NAME:}  & \@author\\
		{\bf TITLE OF STUDY:} & \@title\\
		{\bf MAJOR FIELD:} & \dept\\
		{\bf DATE OF DEGREE:}  & \@date
	\end{tabular}
	\vspace{1.5em}
	
	\noindent #1
	\eject
}

% this command does not do anything except creating a page a link in
% the table of contents.
\newcommand{\AbstractArabic}[1]{%
	%-----------------------------------
	%
	%-----------------------------------
	\phantomsection % This ensures correct page numbering in the table of contents
	\addcontentsline{toc}{chapter}{ABSTRACT (ARABIC)}%Add ABSTRACT (ARABIC) to the table of contents as a clickable link with hyperref package
	\label{abstractArabic}
	%\addtocontents{toc}{\contentsline {chapter}{\numberline {}ABSTRACT (ARABIC)}{\pageref{abstractArabic}}}
	%\label{abstractArabic}
	\chapter*{\centering\textarabic{ملخص الرسالة}}%
	
	\vspace*{-1em}%
	\noindent
	\begin{Arabic}%
		\begin{tabular}{rp{12cm}}%
			{\bfseries الاسم:} & \arname\\
			{\bfseries عنوان الدراسة:} & \artitle\\
			{\bfseries التخصص:} & \ardept\\
			{\bfseries تاريخ الدرجة العلمية:} & \ardate\\
		\end{tabular}
		\vspace{1.5em}%
		
		\noindent #1
	\end{Arabic}%
	\eject
}

%\newcommand{\AbstractArabic}[1]{%
%\centerline{\bf \LARGE ARABIC ABSTRACT}\par\vspace{2em}
%\centerline{\bf \LARGE \AR{\ARABS}}
%\ifthenelse{\equal{\program}{MASTER OF SCIENCE}} {} {%
%\vspace{1em}\centerline{\bf \Large \AR{\ARPHD}}}
%
%\begin{flushright}
%\begin{tabular}{rr}
%\AR{\arname}  & {\bf \AR{\ARNAME}}  \\
%\AR{\artitle} & {\bf \AR{\ARTITLE}}  \\
%\AR{\ardept}  & {\bf \AR{\ARDEPT}} \\
%\AR{\ardate}  & {\bf \AR{\ARDATE}} 
%\end{tabular} 
%\end{flushright}
%\vspace{1.5em}
%
%\begin{otherlanguage}{arabic}
%\noindent#1
%\end{otherlanguage}
%\eject
%}



\newenvironment{preamble}{%
	\setstretch{1.5}
	%\thispagestyle{plain}
	%\pagenumbering{roman}
	\eject
	\tableofcontents
	
	\eject
	
	%-----------------------------------
	%
	%-----------------------------------
	\phantomsection%
	\addcontentsline{toc}{chapter}{LIST OF TABLES}%Add LIST OF TABLES to the table of contents as a clickable link with hyperref package
	\label{List ofTables}%
	%\addtocontents{toc}{\contentsline {chapter}{\numberline {}LIST OF TABLES}{\pageref{ListofTables}}}
	%\label{ListofTables}
	\listoftables
	
	\eject
	
	%-----------------------------------
	%
	%-----------------------------------
	\phantomsection % This ensures correct page numbering in the table of contents
	\addcontentsline{toc}{chapter}{LIST OF FIGURES}%Add LIST OF FIGURES to the table of contents as a clickable link with hyperref package
	\label{ListofFigures}%
	%\addtocontents{toc}{\contentsline {chapter}{\numberline {}LIST OF FIGURES}{\pageref{ListofFigures}}}
	%\label{ListofFigures}
	\listoffigures
	
	\eject
	
	\setstretch{2}
	
}{%
	\eject
	\pagestyle{plain}
	\pagenumbering{arabic}
	\eject
}

\newcommand{\Abbreviations}{%
	\addtocontents{toc}{\contentsline {chapter}{\numberline {}LIST OF ABBREVIATIONS}{\pageref{Abbreviations}}}
	\label{Abbreviations}
	%\chapter*{\centering LIST OF ABBREVIATIONS}
	%\vspace*{-1em}
	%\setstretch{2}
	%\noindent #1
	
	%\eject
}

\usepackage[top    = 2.5cm,%
left   = 3.75cm,%
right  = 2.5cm,%
bottom = 2.6cm]{geometry}

%\usepackage[utf8]{inputenc}             % for standard unicode Arabic encoding
%\usepackage[arabic, english]{babel}     % for multi-lingual TeX support
%\input{strings}
%
%\ARABS{ملخص الرسالة}
%\ARNAME{الاسم:}
%\ARTITLE{عنوان الرسالة:}
%\ARDEPT{التخصص:}
%\ARDATE{تاريخ التخريج:}
%\ARPHD{درجة الدكتوراة في فلسفة}
\endinput
%%
%% End of file `kfupm.cls'.
