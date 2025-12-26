
%========= File containing the ISIPFE LaTex Class =========%
% Produced based on "mqthesis.cls" and isipfe.cls v1       %
%                                                          %
% Copyright (C) ISI - All Rights Reserved                  %
% Proprietary                                              %
% Written by Med Hossam <med.hossam@gmail.com>, April 2016 %
%                                                          %
% @author: HEDHILI Med Houssemeddine                       %
% @linkedin: http://tn.linkedin.com/in/medhossam           %
%==========================================================%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{isipfe}[15/04/2016 ISI PFE LaTeX Class]

% ifthenelse for if loops
\RequirePackage{ifthen}

% if two condidates
\newboolean{isBinomal}
\setboolean{isBinomal}{false}
\DeclareOption{isBinomal}{\setboolean{isBinomal}{true}}

\newboolean{wantToTypeCompanyAddress}
\setboolean{wantToTypeCompanyAddress}{false}
\DeclareOption{wantToTypeCompanyAddress}{\setboolean{wantToTypeCompanyAddress}{true}}

% finished processing options
\ProcessOptions\relax

% load the book class using a4paper
\LoadClass[12pt,a4paper, oneside]{book}
\usepackage[a4paper]{geometry}
\RequirePackage{newtxtext}
\RequirePackage{newtxmath}

% give the header a bit more room for fancyhdr below
% otherwise LaTeX will spew on each page
\addtolength{\headheight}{2.5pt}

% first set to zero ... 
\setlength{\oddsidemargin}{-1in}
\setlength{\evensidemargin}{-1in}
\setlength{\topmargin}{-1in}       

% adjust these if printer is off by a bit
\setlength{\hoffset}{0mm}
\setlength{\voffset}{0mm}

% PS also that the optimal number of characters per line 
% for readability is only 60-70, we're over so we'll be a
% bit more generous on the evensidemargin

\addtolength{\oddsidemargin}{2cm} 
\addtolength{\evensidemargin}{2cm}
\addtolength{\topmargin}{12mm}

% set up some of the spacing
\setlength{\marginparwidth}{40pt}  
\setlength{\marginparsep}{10pt}
\setlength{\headsep}{0.2in}

% A4 dimensions [mm]: 209.903 x 297.039
\setlength{\textwidth}{21 cm}
\setlength{\textheight}{30 cm}

% fix up width
\addtolength{\textwidth}{-\oddsidemargin}
\addtolength{\textwidth}{-\evensidemargin}
% now we've added 2inches in setting up margins
\addtolength{\textwidth}{-2in}

% fix up height
\addtolength{\textheight}{-2\topmargin}
\addtolength{\textheight}{-\headheight}
\addtolength{\textheight}{-\headsep}
\addtolength{\textheight}{-\footskip}
% now we've added 2inches in setting up margins
\addtolength{\textheight}{-2in}

\brokenpenalty=10000   % dunno what this does, maybe handy

% this stops one figure taking up a whole page and lets more text onto
% the one page when a figure exists
\renewcommand\floatpagefraction{0.8} %   Default = 0.5

%% Defining section, subsection and subsubsection spacing
\usepackage{titlesec}
\titlespacing*{\section}{0pt}{5mm}{3pt}
\titlespacing*{\subsection}{6mm}{1.5pt}{10pt}
\titlespacing*{\subsubsection}{8mm}{2pt}{6pt}

\titleformat{\paragraph}[hang]{\normalfont\normalsize\bfseries}{\theparagraph}{1em}{}
\titlespacing{\paragraph}{0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}
\titlespacing*{\paragraph}{10mm}{2pt}{6pt}
%%% load the required packages
% fancyhdr for nice, fancy headings
\RequirePackage{fancyhdr}
% ccaption for good caption handling
\RequirePackage{ccaption}
% xspace so that spaces after commands are handled correctly
\RequirePackage{xspace}

%================ Languages used in the doc ================%
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[french,english]{babel}

%============== To Enable List Customization ==============%
\usepackage{enumitem}
\usepackage{datatool}% http://ctan.org/pkg/datatool
\newcommand{\sortitem}[2][\relax]{%
  \DTLnewrow{list}% Create a new entry
  \DTLnewdbentry{list}{sortlabel}{#1}
  \DTLnewdbentry{list}{description}{#2}% Add entry description
}
\newenvironment{sortedlist}{%
  \DTLifdbexists{list}{\DTLcleardb{list}}{\DTLnewdb{list}}% Create new/discard old list
}{%
  \DTLsort{sortlabel}{list}% Sort list
  \begin{enumerate} % Use enumerate instead of itemize
    \DTLforeach*{list}{\theDesc=description}{%
      \item \theDesc}% Print each item
  \end{enumerate}% Close enumerate
}

%================= Defining Custom Colors =================%
\usepackage{color}
\definecolor{isiBlue}{RGB}{31, 78, 121}

%================= configuring minitoc ==================%
\usepackage[french]{minitoc}
\mtcsettitle{minitoc}{Plan}
\setcounter{minitocdepth}{2}
\mtcsetrules{minitoc}{off}
\mtcsetoffset{minitoc}{-1.0em}

%% disabling chapter numbers
\newcommand{\filterminitoc}[1]{#1}
\renewcommand{\thesection}{\csname filterminitoc \endcsname{\arabic{chapter}.}\arabic{section}}
\newcommand{\minitocsection}{\begingroup\renewcommand{\filterminitoc}[1]{}\minitoc\endgroup}

%=============== Customizing Chapters Names ===============%
\usepackage{pstcol}
\makeatletter
\def\thickhrulefill{\leavevmode \leaders \hrule height 1.2ex \hfill \kern \z@}

\def\@makechapterhead#1{
    \vspace*{90\p@}%
    {\parindent \z@ \centering \reset@font
        \thickhrulefill\quad 
        \scshape\bfseries\textit{\@chapapp{}  \thechapter}  
        \quad \thickhrulefill
        \par\nobreak
        \vspace*{10\p@}%
        \interlinepenalty\@M
        \hrule
        \vspace*{10\p@}%
        \Huge \bfseries #1 \par\nobreak
        \par
        \vspace*{10\p@}%
        \hrule
        \vskip 50\p@
    }
    \minitocsection
    \thispagestyle{empty}%
    \newpage
}
\def\@makeschapterhead#1{\hbox{%
    \huge\hbox{\textbf{#1}}%
}\par\vskip 1cm}

%============== Table & Figure Captions Style ==============%

\usepackage{caption}
\captionsetup[table]{
  labelfont=bf,
  labelsep = newline,
  name = Tableau,
  justification=centering,
  singlelinecheck=false,%%%%%%% a single line is centered by default
  labelsep=colon,
  skip = \medskipamount}

\captionsetup[figure]{
  labelfont=bf,
  labelsep = newline,
  name = Figure,
  justification=centering,
  singlelinecheck=false,
  labelsep=colon,
  skip = \medskipamount}

%=============== Defining Fancy Page Styles ===============%

\pagestyle{fancy}

\fancypagestyle{frontmatter}{%
  \fancyhf{}% clear all header and footer fields
  \renewcommand{\footrulewidth}{0.3pt}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyfoot[r]{\footnotesize \thepage}%
}

\fancypagestyle{plain}{%
  \fancyhf{}% clear all header and footer fields
  \renewcommand{\footrulewidth}{0.3pt}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyfoot[c]{\footnotesize \thepage}%
}

\fancypagestyle{cover}{
  \fancyhf{}
  \renewcommand{\footrulewidth}{0pt}%
  \renewcommand{\headrulewidth}{0pt}%
  \setlength{\headheight}{0mm}
  \setlength{\footskip}{8mm}
\fancyfoot[C]{
\vspace{-1.1cm}
\makebox[\textwidth][c]{\includegraphics[width=1.1\textwidth]{supcom_bottom}}
 }
}

\fancypagestyle{backcover}{
  \fancyhf{} %clear all header and footer fields
  \newgeometry{left=12mm,top=3cm,right=12mm}
  \renewcommand{\footrulewidth}{0pt}%
  \renewcommand{\headrulewidth}{0pt}%
  \setlength{\headheight}{0mm}
  \setlength{\footskip}{0mm}

  %%% ISI Footer %%%

}

%%%%% Fancyhdr stuff
% define how headers are marked, for details, see fancyhdr docs
%\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
%\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
% define where sections, chapters and pagenumbers are put
% see fancyhdr docs for details

% the \nouppercase stops book.cls making the contents, bibliography
% and index headers from being all in uppercase.
% The options used here are essentially that in Lamport's book, but
% with small caps for the headings.
\fancyhf{}
%\fancyhead[LE,RO]{\nouppercase{\thepage}}
%\fancyhead[L]{\nouppercase{\leftmark}}
\rhead{\nouppercase{\leftmark}}
\renewcommand{\headrulewidth}{0.3pt}
\renewcommand{\footrulewidth}{0.3pt}
\rfoot{\centering \thepage}

% use 1.5 line spacing
\renewcommand{\baselinestretch}{1.5}

%\usepackage{play}
%\usepackage[grey,times]{quotchap}
%Options: Sonny, Lenny, Glenn, Conny, Rejne, Bjarne, Bjornstrup
%\usepackage[Bjornstrup]{fncychap}

\usepackage[french]{minitoc}
\usepackage[nottoc,notlof, notlot]{tocbibind}
				% allows the table of contents, bibliography
				% and index to be added to the table of
				% contents if desired, the option used
				% here specifies that the table of
				% contents is not to be added.
				% tocbibind needs to be after natbib
				% otherwise bits of it get trampled.

% standard graphics package for inclusion of images and eps files into LaTeX document
\usepackage{graphicx}
\usepackage{graphics}

