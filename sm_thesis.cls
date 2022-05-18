% !TEX encoding = UTF-8 Unicode

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{sm_thesis}[SM thesis class]

% Load memoir
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[oneside,12pt]{memoir}

\RequirePackage{etoolbox}
\RequirePackage[hyphens]{url}
\RequirePackage{lipsum}
\RequirePackage{graphicx}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\usepackage{fourier}
\RequirePackage[activate={true,nocompatibility}]{microtype}
\RequirePackage[english, spanish,es-tabla,es-nodecimaldot]{babel}
\RequirePackage{titlesec}
\RequirePackage[squaren, Gray, cdot]{SIunits}
%\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage[authoryear,sort&compress]{natbib}
\RequirePackage{bibunits}
\RequirePackage{xifthen}
\RequirePackage{mathtools}
\defaultbibliographystyle{apacite}
\usepackage[ruled,vlined]{algorithm2e}
%\usepackage{algorithm}
\usepackage{graphicx}
\usepackage{rotating}
\usepackage{csquotes}
\usepackage{caption}
\usepackage{subcaption}
\usepackage{float}
\graphicspath{ {/images/} }

\newcolumntype{L}{>{\arraybackslash}m{3cm}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para cortar las formulas largas inline
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\splitatcommas}[1]{%
  \begingroup
  \begingroup\lccode`~=`, \lowercase{\endgroup
    \edef~{\mathchar\the\mathcode`, \penalty0 \noexpand\hspace{0pt plus 1em}}%
  }\mathcode`,="8000 #1%
  \endgroup
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Redefinición del nombre de la TOC
% Sino "Índice General"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\spanishcontentsname{Tabla de Contenido}
\renewcommand\spanishchaptername{Cap\'{\i}tulo}

% Page geometry
\RequirePackage[a4paper,top=1in,bottom=1in,left=1.5in,right=1in,headsep=\dimexpr 0.25in-1em,marginparwidth=1.25in]{geometry}

% Page style
\makeoddhead{headings}{}{}{\thepage}
\makeevenhead{headings}{}{}{\thepage}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Primera página de cada capítulo sin número
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\assignpagestyle{\chapter}{empty}



\newcolumntype{Y}{>{\centering\arraybackslash}X}
% Formatting of ToC and lists
\setcounter{tocdepth}{3}
\let\listoffigurestables\listoffigures
\appto{\tableofcontents}{\thispagestyle{empty}\clearpage}
\appto{\listoffigurestables}{\thispagestyle{empty}\clearpage}
\appto{\listoffigures}{\thispagestyle{empty}\clearpage}
\appto{\listoftables}{\thispagestyle{empty}\clearpage}
%\renewcommand{\contentsname}{Table of Contents}
%\renewcommand{\listfigurename}{List of Illustrations}
%\renewcommand{\listtablename}{List of Tables}

% \renewcommand{\listfigurename}{List of Illustrations and/or Tables}

\addtocontents{toc}{\protect\vskip 35pt}
\addtocontents{toc}{\protect\SingleSpacing}
\addtocontents{lof}{\protect\vskip 35pt}
%% In case single spacing is desired later
% \addtocontents{lof}{\protect\SingleSpacing}
% \addtocontents{lot}{\protect\SingleSpacing}
\addtocontents{lof}{{\protect\itshape {N\'umero}}\protect\hfill{\protect\itshape {P\'agina}}\protect\par}
\addtocontents{lot}{{\protect\itshape N\'umero}\protect\hfill{\protect\itshape P\'agina}\protect\par}

\setlength{\cftbeforechapterskip}{0pt}

%% For formatting chapter numbers as Roman but
%% not touch appendix alphabets
\RequirePackage{xstring}
\newcommand*{\IsInteger}[3]{%
    \IfStrEq{#1}{ }{#3}{%
        \IfInteger{#1}{#2}{#3}%
    }%
}%
\newcommand{\formatchapternumber}[1]{%
  \IsInteger{#1}{\uppercase\expandafter{\romannumeral #1\relax}}{#1}%
}

\renewcommand{\chapternumberline}[1]{\chaptername\space\formatchapternumber{#1}:\space}
\patchcmd{\cftchapterleader}{\bfseries}{\normalfont}{}{}
\renewcommand{\cftchapterfont}{\normalfont}
\renewcommand{\cftchapterpagefont}{\normalfont}
\renewcommand{\cftchapterdotsep}{\cftdotsep}
\setlength{\cftsectionnumwidth}{2em}

% Merged list of figures and tables -- not needed
% \def\table{\def\figurename{Table}\figure}
% \let\endtable\endfigure

\setlength{\cftbeforefigureskip}{0pt}
\renewcommand{\cftfiguredotsep}{\cftdotsep}
\settowidth\cftfigurenumwidth{\itshape Number}
\renewcommand\cftfigurepresnum{\hfill}
\renewcommand\cftfigureaftersnum{\hskip1em}

\setlength{\cftbeforetableskip}{0pt}
\renewcommand{\cfttabledotsep}{\cftdotsep}
\settowidth\cfttablenumwidth{\itshape Number}
\renewcommand\cfttablepresnum{\hfill}
\renewcommand\cfttableaftersnum{\hskip1em}

\apptocmd{\appendix}{%
  \addtocontents{toc}{%
    \protect\renewcommand{\protect\chaptername}{Appendix}
  }%
}{}{}

% \subsection and onwards shouldn't be numbered
\setcounter{secnumdepth}{3}
\RequirePackage{letterspace} % not so heavy...

% Chapter headings
\renewcommand{\insertchapterspace}{}
\setlength{\midchapskip}{\onelineskip}
\setlength{\afterchapskip}{1.5\onelineskip}
\renewcommand{\chapternamenum}{\space\space}
\renewcommand{\chapterheadstart}{\clearforchapter}
\renewcommand{\chapnamefont}{\SingleSpacing\centering\normalsize\textls[150]}
\renewcommand{\chapnumfont}{\normalsize}
\renewcommand{\chaptitlefont}{\SingleSpacing\centering\normalfont\large}
\renewcommand{\printchaptertitle}[1]{\chaptitlefont\MakeUppercase{#1}}

% Add a command to create an extra chapter with TOC entry.
\newcommand{\extrachapter}[2][\@empty]{%
  \chapter*{#2}%
  \addcontentsline{toc}{chapter}{\ifx#1\@empty{#2}\else{#1}\fi}}

\newcommand{\extrachapterwithoutchaptertitle}[2][\@empty]{%
  \addcontentsline{toc}{chapter}{\ifx#1\@empty{#2}\else{#1}\fi}}


% Section headings
\setsecheadstyle{\normalfont\bfseries}
\setbeforesecskip{\onelineskip}
\setaftersecskip{1pt}
\setsubsecheadstyle{\normalfont\bfseries}
\setbeforesubsecskip{\onelineskip}
\setaftersubsecskip{1pt}

\aliaspagestyle{chapter}{headings}

%
% Define spacing for use on titlepage
%
\def\titleskip{\vskip 4\bigskipamount} %% Whitespace after title
\def\authorskip{\vskip 2\bigskipamount} %% Whitespace after author

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Utilizar \adjustpenalty después del \begin
% de una lista para evitar su partición
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\adjustpenalty{\@beginparpenalty\@M \@itempenalty\@M}



%
% Additional titlepage definitions
%
\newcommand{\grado}{\gdef\@grado}
\grado{título profesional} % Default is Ph.D.
\newcommand{\codigo}{\gdef\@codigo}
\newcommand{\university}{\gdef\@university}
\newcommand{\facultad}{\gdef\@facultad}
\newcommand{\subfacultad}{\gdef\@subfacultad}
\newcommand{\escuela}{\gdef\@escuela}
\newcommand{\presidente}{\gdef\@presidente}
\newcommand{\jurado}{\gdef\@jurado}
\newcommand{\carrera}{\gdef\@carrera}
\newcommand{\asesoruno}{\gdef\@asesoruno}
\newcommand{\asesordos}{\gdef\@asesordos}
\newcommand{\unilogo}{\gdef\@unilogo}

\def\jurado#1{\def\@jurado{#1}}
\jurado{}

\def\asesordos#1{\def\@asesordos{#1}}
\asesordos{}

\newif\ifdosasesores
\ifthenelse{\isempty{@asesordos}}{\dosasesoresfalse}{\dosasesorestrue}

\def\university#1{\def\@university{#1}}
\university{Universidad Nacional Mayor de San Marcos}

\def\subuni#1{\def\@subuni{#1}}
\subuni{Universidad del Perú. Decana de América}

\def\facultad#1{\def\@facultad{#1}}
\facultad{Facultad de Ingeniería de Sistemas e Informática}

\def\escuela#1{\def\@escuela{#1}}
\escuela{Escuela Profesional de Ingeniería de Sistemas}

\def\unilogo#1{\def\@unilogo{#1}}
\unilogo{logo1.jpeg}


%\unilogo{logo.png} % SM logo

\newcommand{\address}{\gdef\@address}
\address{Lima, Per\'u}

% \newcommand{\copyyear}{\gdef\@copyyear}
\newcommand{\sustentacion}{\gdef\@sustentacion}
% Don't put in a default year value

%
\newcommand{\orcid}[1]{\gdef\@orcid{#1}}
\orcid{xxxxx}
\newcommand{\rightsstatement}[1]{\gdef\@rightsstatement{#1}}
\rightsstatement{All rights reserved}

\newcommand{\makecopyright}{%
 {\parindent=0pt
 \null % Forces rest to bottom of page
 \vfill
 \begin{center}
   \SingleSpacing
   \copyright~\@copyyear\par
   \@author\\ORCID: \@orcid\par
   \@rightsstatement\par
 \end{center}}
 \newpage
} %% End of \makecopyright

\renewcommand{\maketitle}[1][]{%
 \begin{titlingpage}
   \OnehalfSpacing
   \let\footnotesize\small \let\footnoterule\relax \setcounter{page}{1}
   \vskip-\headsep
   \begin{center}
    \vspace{0.7cm}
   \includegraphics[width=1in]{\@unilogo} \\
   \vspace{0.7cm}
   \Large\textbf{\@university}\\
      \textbf{\@subuni}\\
   {\@facultad}\\
   {\@escuela}\\
    \vspace{1cm}
     {\SingleSpacing\Large\textbf\@title\par}
     \vspace{1cm}
     \centering\textbf{Tesis} \\
     Para optar el {\@grado}\\
     \vspace{1cm}
     {\textbf{Autor}\\ 
     \@author}\\
     \vspace{1cm}
	{\textbf{Asesor}}\\
    \@asesoruno\par
    \vspace{1cm}
    \@address\\
     %\@copyyear\\
     {\normalsize\@sustentacion\par}
   \end{center}
   \newpage

% aqui texto para aprobacion de tesis.
 \end{titlingpage}
 %\newpage
 \pagenumbering{roman}
 \setcounter{page}{2}
 %\makecopyright
} %% End of \maketitle


% The abstract and acknowledgments are treated as unnumbered chapters
% with Table of Contents entries.
\renewenvironment{abstract}
  {\extrachapter{Abstract}}
  {\clearpage}


\newenvironment{acknowledgments}
  {\extrachapter{Acknowledgments}}
  {\clearpage}
% although `acknowledgments' is preferred
\newenvironment{agradecimientos}{\extrachapterwithoutchaptertitle{Agradecimientos}\cleardoublepage\null\vspace{\stretch{1}}\begin{flushright}\textsc{\large{Agradecimientos}}\end{flushright}\vspace{1cm}}{\vspace{\stretch{2}}\null\thispagestyle{empty}\clearpage}

\newenvironment{dedicatoria}{\extrachapterwithoutchaptertitle{Dedicatoria}\cleardoublepage\null\vspace{\stretch{1}}\begin{flushright}\textsc{\large{Dedicatoria}}\vspace{1cm}\\ \itshape}{\end{flushright}\vspace{\stretch{2}}\null\thispagestyle{empty}\clearpage}
% \newenvironment{dedicatoria}
%  {\begin{flushright}}{\end{flushright}\clearpage}

% non-zero paragraph skip
\nonzeroparskip
\setlength{\parindent}{0pt}
\OnehalfSpacing

\nobibintoc

\AtBeginDocument{
  \@ifpackageloaded{biblatex}
  {usepackage[backend=biber,style=apa,citestyle=apa]{biblatex}
  \DeclareFieldFormat{addendum}{}
  \AtBeginBibliography{\SingleSpacing}
  \setlength{\bibitemsep}{\parskip}
  \defbibheading{publishedcontent}{\extrachapter{Contenido publicado y contribuciones}}
  \defbibnote{pcinstructions}{[Include a bibliography of published articles or other material that are included as part of the thesis.  Describe your role with the each article and its contents.  Citations must include DOIs or publisher URLs if available electronically.

If you are incorporating any third-party material in the thesis, including works that you have authored/co-authored but for which you have transferred copyright, you must indicate that permission has been secured to use the material. For example: ``Fig.~2 reprinted with permission from the copyright holder, {holder name}''

Add the option \texttt{iknowwhattodo} to this environment to dismiss this message.]}

  \newenvironment{publishedcontent}[1][]{
    \newtoggle{printinstr}
    \ifstrequal{#1}{iknowwhattodo}
         {\togglefalse{printinstr}}
         {\toggletrue{printinstr}}
    \DeclareFieldFormat{addendum}{\\##1}
    \begin{refsection}
    %% list in reverse chronological order
    \begin{refcontext}[sorting=ydnt]{}
  }{
     \iftoggle{printinstr}{
\printbibliography[heading=publishedcontent,prenote=pcinstructions]
     }{
\printbibliography[heading=publishedcontent]
     }
     \end{refcontext}
     \end{refsection}
     \citereset
  }

  \newcommand{\publishedas}[1]{
    \begin{refsection}
    \nocite{#1}
    \printbibliography[heading=none]
    \end{refsection}
    \citereset
  }
}{%%%%% so if not using biblatex
  \@ifpackageloaded{natbib}{}{\PackageError{utec-thesis}{Using bibtex without natbib! PLEASE load natbib, or even better, use biblatex (and the relevant template for that!}{}}
  \apptocmd{\thebibliography}{\phantomsection\addcontentsline{toc}{chapter}{\bibname}}{}{}
  
  \@ifpackageloaded{bibunits}{
    \newenvironment{publishedcontent}[1][]{%
      \ifstrequal{#1}{iknowwhattodo}{}
        {\renewcommand{\bibpreamble}{
          Include a bibliography of published articles or other material that are included as part of the thesis.  Describe your role with the each article and its contents.  Citations must include DOIs or publisher URLs if available electronically.\par
If you are incorporating any third-party material in the thesis, including works that you have authored/co-authored but for which you have transferred copyright, you must indicate that permission has been secured to use the material. For example: ``Fig.~2 reprinted with permission from the copyright holder, {holder name}''\par
Add the option \texttt{iknowwhattodo} to this environment to dismiss this message.\par}}

      \renewcommand{\bibsection}{}
      \begin{bibunit}
    }{\end{bibunit}}}
  { %% no bibunit; raise warning
    \PackageWarning{utec_thesis}{Sorry, publishedcontent is only available with biblatex! Please format the list manually instead.}
    \textbf{Sorry, publishedcontent is only available  with biblatex! Please format the list manually instead.}\par
  }
  
  
  \@ifpackageloaded{bibunits}{
     \newcommand{\publishedas}[2]{%
        \begin{bibunit}%
        \renewcommand{\bibsection}{}%
        \renewcommand{\bibnumfmt}[1]{}%
        \nocite{#2}\putbib[#1]
        \end{bibunit}%
     }
  }{%
    \newcommand{\publishedas}[1]{%
      \PackageWarning{utec_thesis}{Sorry, \textbackslash publishedas is only available with biblatex or bibtex+bibunits! Please format the "published as" statement manually instead.}
      \textbf{Sorry, \textbackslash publishedas is only available  with biblatex or bibtex+bibunits! Please format the ``published as'' statement manually instead.}\par}
  }

  \setlength{\bibitemsep}{\parskip}
  \renewcommand{\bibfont}{\SingleSpacing}
  
  }% END if not using biblatex

} %% END AtBeginDocument

% for nomenclature
\RequirePackage[intoc]{nomencl}
\makenomenclature
\renewcommand{\nompreamble}{\SingleSpacing\itemindent 0pt}
\renewcommand{\nomlabel}[1]{\bfseries #1.}
\renewcommand{\nomentryend}{.}

% for index
\RequirePackage{imakeidx}
\makeindex[columns=1,options=-s simple_letters]

% for endnotes
\RequirePackage{endnotes}
\renewcommand{\notesname}{}
\pretocmd{\theendnotes}{\clearpage}{}{}

% no more pagenumbers in the TOC
\newcommand{\pocketmaterial}{\addtocontents{toc}{\cftpagenumbersoff{chapter}}}


\endinput