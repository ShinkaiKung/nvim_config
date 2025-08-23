local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- Make sure path exists and permissions are correct

-- Helper function for visual selection
local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

return {
  -- DOCUMENT STRUCTURE
  s({ trig = "section", dscr = "section" },
    fmta("\\section{<>}", { d(1, get_visual) })
  ),
  s({ trig = "subsec", dscr = "subsection" },
    fmta("\\subsection{<>}", { d(1, get_visual) })
  ),
  s({ trig = "subsubsec", dscr = "subsubsection" },
    fmta("\\subsubsection{<>}", { d(1, get_visual) })
  ),
  s({ trig = "parag", dscr = "paragraph" },
    fmta("\\paragraph{<>}", { d(1, get_visual) })
  ),
  s({ trig = "subparag", dscr = "subparagraph" },
    fmta("\\subparagraph{<>}", { d(1, get_visual) })
  ),
  s({ trig = "item", dscr = "Item in itemize/enumerate" },
    fmta("\\item <>", { d(1, get_visual) })
  ),


  -- TEXT FORMATTING
  s({ trig = "tt", dscr = "Monospace text"},
    fmta("\\texttt{<>}", { d(1, get_visual) })
  ),
  s({ trig = "tii", dscr = "Italic text"},
    fmta("\\textit{<>}", { d(1, get_visual) })
  ),
  s({ trig = "tbb", dscr = "Bold text"},
    fmta("\\textbf{<>}", { d(1, get_visual) })
  ),
  s({ trig = "tsc", dscr = "Small caps text" },
    fmta("\\textsc{<>}", { d(1, get_visual) })
  ),
  s({ trig = "emph", dscr = "Emphasized text" },
    fmta("\\emph{<>}", { d(1, get_visual) })
  ),

  -- MATH ENVIRONMENTS
  s({ trig = "mk", dscr = "Inline math"},
    fmta("$<>$", { d(1, get_visual) })
  ),
  s({ trig = "dm", dscr = "Display math"},
    fmta("\\[<>\\]", { i(1) })
  ),
  s({ trig = "eq", dscr = "Equation environment" },
    fmta(
      [[
      \begin{equation}
          <>
      \end{equation}
      ]],
      { i(1) }
    )
  ),
  s({ trig = "eq*", dscr = "Unnumbered equation" },
    fmta(
      [[
      \begin{equation*}
          <>
      \end{equation*}
      ]],
      { i(1) }
    )
  ),
  s({ trig = "ali", dscr = "Align environment" },
    fmta(
      [[
      \begin{align}
          <>
      \end{align}
      ]],
      { i(1) }
    )
  ),
  s({ trig = "ali*", dscr = "Unnumbered align" },
    fmta(
      [[
      \begin{align*}
          <>
      \end{align*}
      ]],
      { i(1) }
    )
  ),
  s({ trig = "gat", dscr = "Gather environment" },
    fmta(
      [[
      \begin{gather}
          <>
      \end{gather}
      ]],
      { i(1) }
    )
  ),
  s({ trig = "gat*", dscr = "Unnumbered gather" },
    fmta(
      [[
      \begin{gather*}
          <>
      \end{gather*}
      ]],
      { i(1) }
    )
  ),

  -- FRACTIONS AND POWERS
  s({ trig = "ff", dscr = "Fraction"},
    fmt("\\frac{<>}{<>}", { i(1), i(2) }, { delimiters = "<>" })
  ),
  s({ trig = "//", dscr = "Fraction (alternative)"},
    fmt("\\frac{<>}{<>}", { i(1), i(2) }, { delimiters = "<>" })
  ),
  s({ trig = "sq", dscr = "Square"},
    fmta("<>^{2}", { d(1, get_visual) })
  ),
  s({ trig = "cb", dscr = "Cube"},
    fmta("<>^{3}", { d(1, get_visual) })
  ),
  s({ trig = "td", dscr = "Superscript" },
    fmta("<>^{<>}", { d(1, get_visual), i(2) })
  ),
  s({ trig = "__", dscr = "Subscript" },
    fmta("<>_{<>}", { d(1, get_visual), i(2) })
  ),

  -- ROOTS
  s({ trig = "sr", dscr = "Square root"},
    fmta("\\sqrt{<>}", { d(1, get_visual) })
  ),
  s({ trig = "rr", dscr = "nth root" },
    fmt("\\sqrt[<>]{<>}", { i(1), i(2) }, { delimiters = "<>" })
  ),

  -- SUMS, PRODUCTS, INTEGRALS
  s({ trig = "sum", dscr = "Sum"},
    fmta("\\sum_{<>}^{<>} <>", { i(1, "i=1"), i(2, "n"), i(3) })
  ),
  s({ trig = "prod", dscr = "Product" },
    fmta("\\prod_{<>}^{<>} <>", { i(1, "i=1"), i(2, "n"), i(3) })
  ),
  s({ trig = "lim", dscr = "Limit" },
    fmta("\\lim_{<> \\to <>} <>", { i(1, "n"), i(2, "\\infty"), i(3) })
  ),
  s({ trig = "int", dscr = "Integral" },
    fmta("\\int_{<>}^{<>} <> \\, d<>", { i(1, "a"), i(2, "b"), i(3), i(4, "x") })
  ),
  s({ trig = "oint", dscr = "Contour integral" },
    fmta("\\oint_{<>} <> \\, d<>", { i(1), i(2), i(3) })
  ),
  s({ trig = "iint", dscr = "Double integral" },
    fmta("\\iint_{<>} <> \\, d<> \\, d<>", { i(1), i(2), i(3, "x"), i(4, "y") })
  ),
  s({ trig = "iiint", dscr = "Triple integral" },
    fmta("\\iiint_{<>} <> \\, d<> \\, d<> \\, d<>", { i(1), i(2), i(3, "x"), i(4, "y"), i(5, "z") })
  ),

  -- MATRICES
  s({ trig = "pmat", dscr = "Parentheses matrix" },
    fmta(
      [[
      \begin{pmatrix}
          <>
      \end{pmatrix}
      ]],
      { i(1) }
    )
  ),
  s({ trig = "bmat", dscr = "Brackets matrix" },
    fmta(
      [[
      \begin{bmatrix}
          <>
      \end{bmatrix}
      ]],
      { i(1) }
    )
  ),
  s({ trig = "vmat", dscr = "Determinant matrix" },
    fmta(
      [[
      \begin{vmatrix}
          <>
      \end{vmatrix}
      ]],
      { i(1) }
    )
  ),
  s({ trig = "Vmat", dscr = "Double bars matrix" },
    fmta(
      [[
      \begin{Vmatrix}
          <>
      \end{Vmatrix}
      ]],
      { i(1) }
    )
  ),

  -- CASES
  s({ trig = "case", dscr = "Cases environment" },
    fmta(
      [[
      \begin{cases}
          <> & \text{if } <> \\
          <> & \text{if } <>
      \end{cases}
      ]],
      { i(1), i(2), i(3), i(4) }
    )
  ),

  -- THEOREMS AND PROOFS
  s({ trig = "thm", dscr = "Theorem environment" },
    fmta(
      [[
      \begin{theorem}
          <>
      \end{theorem}
      ]],
      { i(1) }
    )
  ),
  s({ trig = "def", dscr = "Definition environment" },
    fmta(
      [[
      \begin{definition}
          <>
      \end{definition}
      ]],
      { i(1) }
    )
  ),
  s({ trig = "lem", dscr = "Lemma environment" },
    fmta(
      [[
      \begin{lemma}
          <>
      \end{lemma}
      ]],
      { i(1) }
    )
  ),
  s({ trig = "cor", dscr = "Corollary environment" },
    fmta(
      [[
      \begin{corollary}
          <>
      \end{corollary}
      ]],
      { i(1) }
    )
  ),
  s({ trig = "prf", dscr = "Proof environment" },
    fmta(
      [[
      \begin{proof}
          <>
      \end{proof}
      ]],
      { i(1) }
    )
  ),

  -- GENERIC ENVIRONMENT
  s({ trig = "env"},
    fmta(
      [[
      \begin{<>}
          <>
      \end{<>}
      ]],
      { i(1), i(2), rep(1) }
    )
  ),

  s({ trig = "fx" },
    {
      t("f(x)"),
    }
  ),

  -- GREEK LETTERS (lowercase) - 重新设计避免冲突
  s({ trig = ";a", snippetType = "autosnippet" }, { t("\\alpha") }),
  s({ trig = ";b", snippetType = "autosnippet" }, { t("\\beta") }),
  s({ trig = ";g", snippetType = "autosnippet" }, { t("\\gamma") }),
  s({ trig = ";d", snippetType = "autosnippet" }, { t("\\delta") }),
  s({ trig = ";e", snippetType = "autosnippet" }, { t("\\epsilon") }),
  s({ trig = ";ve", snippetType = "autosnippet" }, { t("\\varepsilon") }),
  s({ trig = ";z", snippetType = "autosnippet" }, { t("\\zeta") }),
  s({ trig = ";h", snippetType = "autosnippet" }, { t("\\eta") }),
  s({ trig = ";q", snippetType = "autosnippet" }, { t("\\theta") }), -- 改为 q
  s({ trig = ";vq", snippetType = "autosnippet" }, { t("\\vartheta") }),
  s({ trig = ";i", snippetType = "autosnippet" }, { t("\\iota") }),
  s({ trig = ";k", snippetType = "autosnippet" }, { t("\\kappa") }),
  s({ trig = ";l", snippetType = "autosnippet" }, { t("\\lambda") }),
  s({ trig = ";m", snippetType = "autosnippet" }, { t("\\mu") }),
  s({ trig = ";n", snippetType = "autosnippet" }, { t("\\nu") }),
  s({ trig = ";x", snippetType = "autosnippet" }, { t("\\xi") }),
  s({ trig = ";p", snippetType = "autosnippet", priority = 100 }, { t("\\pi") }),
  s({ trig = ";vp", snippetType = "autosnippet" }, { t("\\varpi") }),
  s({ trig = ";r", snippetType = "autosnippet" }, { t("\\rho") }),
  s({ trig = ";vr", snippetType = "autosnippet" }, { t("\\varrho") }),
  s({ trig = ";s", snippetType = "autosnippet" }, { t("\\sigma") }),
  s({ trig = ";vs", snippetType = "autosnippet" }, { t("\\varsigma") }),
  s({ trig = ";t", snippetType = "autosnippet" }, { t("\\tau") }),
  s({ trig = ";u", snippetType = "autosnippet" }, { t("\\upsilon") }),
  s({ trig = ";f", snippetType = "autosnippet" }, { t("\\phi") }),
  s({ trig = ";vf", snippetType = "autosnippet" }, { t("\\varphi") }),
  s({ trig = ";c", snippetType = "autosnippet" }, { t("\\chi") }),
  s({ trig = ";y", snippetType = "autosnippet" }, { t("\\psi") }), -- 改为 y
  s({ trig = ";w", snippetType = "autosnippet" }, { t("\\omega") }),

  -- GREEK LETTERS (uppercase) - 避免冲突
  s({ trig = ";G", snippetType = "autosnippet" }, { t("\\Gamma") }),
  s({ trig = ";D", snippetType = "autosnippet" }, { t("\\Delta") }),
  s({ trig = ";Q", snippetType = "autosnippet" }, { t("\\Theta") }), -- 改为 Q
  s({ trig = ";L", snippetType = "autosnippet" }, { t("\\Lambda") }),
  s({ trig = ";X", snippetType = "autosnippet" }, { t("\\Xi") }),
  s({ trig = ";P", snippetType = "autosnippet" }, { t("\\Pi") }),
  s({ trig = ";S", snippetType = "autosnippet" }, { t("\\Sigma") }),
  s({ trig = ";U", snippetType = "autosnippet" }, { t("\\Upsilon") }),
  s({ trig = ";F", snippetType = "autosnippet" }, { t("\\Phi") }),
  s({ trig = ";Y", snippetType = "autosnippet" }, { t("\\Psi") }), -- 改为 Y
  s({ trig = ";W", snippetType = "autosnippet" }, { t("\\Omega") }),

  -- MATH OPERATORS
  s({ trig = "!="}, { t("\\neq") }),
  s({ trig = "<="}, { t("\\leq") }),
  s({ trig = ">="}, { t("\\geq") }),
  s({ trig = "<<"}, { t("\\ll") }),
  s({ trig = ">>"}, { t("\\gg") }),
  s({ trig = "~~"}, { t("\\sim") }),
  s({ trig = "~="}, { t("\\approx") }),
  s({ trig = "=~"}, { t("\\cong") }),
  s({ trig = "prop"}, { t("\\propto") }),
  s({ trig = "para"}, { t("\\parallel") }),
  s({ trig = "perp"}, { t("\\perp") }),

  -- SET THEORY
  s({ trig = "inn"}, { t("\\in") }),
  s({ trig = "notin", dscr = "Not in" }, { t("\\notin") }),
  s({ trig = "sub"}, { t("\\subset") }),
  s({ trig = "sube", dscr = "Subset or equal" }, { t("\\subseteq") }),
  s({ trig = "sup"}, { t("\\supset") }),
  s({ trig = "supe", dscr = "Superset or equal" }, { t("\\supseteq") }),
  s({ trig = "cup"}, { t("\\cup") }),
  s({ trig = "cap"}, { t("\\cap") }),
  s({ trig = "setminus", dscr = "Set minus" }, { t("\\setminus") }),
  s({ trig = "emp"}, { t("\\emptyset") }),
  s({ trig = "CC"}, { t("\\mathbb{C}") }),
  s({ trig = "RR"}, { t("\\mathbb{R}") }),
  s({ trig = "QQ"}, { t("\\mathbb{Q}") }),
  s({ trig = "ZZ"}, { t("\\mathbb{Z}") }),
  s({ trig = "NN"}, { t("\\mathbb{N}") }),

  -- LOGIC
  s({ trig = "land"}, { t("\\land") }),
  s({ trig = "lor"}, { t("\\lor") }),
  s({ trig = "lnot"}, { t("\\lnot") }),
  s({ trig = "implies", dscr = "Implies" }, { t("\\implies") }),
  s({ trig = "iff"}, { t("\\iff") }),
  s({ trig = "forall", dscr = "For all" }, { t("\\forall") }),
  s({ trig = "exists", dscr = "Exists" }, { t("\\exists") }),

  -- ARROWS
  s({ trig = "to"}, { t("\\to") }),
  s({ trig = "lra"}, { t("\\leftrightarrow") }),
  s({ trig = "Lra"}, { t("\\Leftrightarrow") }),
  s({ trig = "mapsto", dscr = "Maps to" }, { t("\\mapsto") }),

  -- CALCULUS
  s({ trig = "dd", dscr = "Differential d" },
    fmta("\\frac{d<>}{d<>}", { i(1, "y"), i(2, "x") })
  ),
  s({ trig = "ddd", dscr = "Second derivative" },
    fmta("\\frac{d^2<>}{d<>^2}", { i(1, "y"), i(2, "x") })
  ),
  s({ trig = "part", dscr = "Partial derivative" },
    fmta("\\frac{\\partial <>}{\\partial <>}", { i(1), i(2) })
  ),
  s({ trig = "grad", dscr = "Gradient" }, { t("\\nabla") }),
  s({ trig = "div", dscr = "Divergence" }, { t("\\nabla \\cdot") }),
  s({ trig = "curl", dscr = "Curl" }, { t("\\nabla \\times") }),
  s({ trig = "lap", dscr = "Laplacian" }, { t("\\nabla^2") }),

  -- MISCELLANEOUS
  s({ trig = "oo"}, { t("\\infty") }),
  s({ trig = "pm"}, { t("\\pm") }),
  s({ trig = "mp"}, { t("\\mp") }),
  s({ trig = "xx"}, { t("\\times") }),
  s({ trig = "cd"}, { t("\\cdot") }),
  s({ trig = "star"}, { t("\\star") }),
  s({ trig = "ast"}, { t("\\ast") }),
  s({ trig = "oplus", dscr = "Direct sum" }, { t("\\oplus") }),
  s({ trig = "otimes", dscr = "Tensor product" }, { t("\\otimes") }),
  s({ trig = "ell"}, { t("\\ell") }),
  s({ trig = "hbar", dscr = "Reduced Planck constant" }, { t("\\hbar") }),
  s({ trig = "angle", dscr = "Angle" }, { t("\\angle") }),
  s({ trig = "deg", dscr = "Degree symbol" }, { t("^\\circ") }),

  -- DELIMITERS
  s({ trig = "lr(", dscr = "Left right parentheses" },
    fmta("\\left( <> \\right)", { i(1) })
  ),
  s({ trig = "lr[", dscr = "Left right brackets" },
    fmta("\\left[ <> \\right]", { i(1) })
  ),
  s({ trig = "lr{", dscr = "Left right braces" },
    fmta("\\left\\{ <> \\right\\}", { i(1) })
  ),
  s({ trig = "lr|", dscr = "Left right absolute value" },
    fmta("\\left| <> \\right|", { i(1) })
  ),
  s({ trig = "lr<", dscr = "Left right angle brackets" },
    fmta("\\left\\langle <> \\right\\rangle", { i(1) })
  ),

  -- COMMON FUNCTIONS
  s({ trig = "sin", dscr = "Sine" }, { t("\\sin") }),
  s({ trig = "cos", dscr = "Cosine" }, { t("\\cos") }),
  s({ trig = "tan", dscr = "Tangent" }, { t("\\tan") }),
  s({ trig = "cot", dscr = "Cotangent" }, { t("\\cot") }),
  s({ trig = "sec", dscr = "Secant" }, { t("\\sec") }),
  s({ trig = "csc", dscr = "Cosecant" }, { t("\\csc") }),
  s({ trig = "log", dscr = "Logarithm" }, { t("\\log") }),
  s({ trig = "ln", dscr = "Natural logarithm" }, { t("\\ln") }),
  s({ trig = "exp", dscr = "Exponential" }, { t("\\exp") }),
  s({ trig = "min", dscr = "Minimum" }, { t("\\min") }),
  s({ trig = "max", dscr = "Maximum" }, { t("\\max") }),
  s({ trig = "sup", dscr = "Supremum" }, { t("\\sup") }),
  s({ trig = "inf", dscr = "Infimum" }, { t("\\inf") }),
  s({ trig = "arg", dscr = "Argument" }, { t("\\arg") }),
  s({ trig = "dim", dscr = "Dimension" }, { t("\\dim") }),
  s({ trig = "ker", dscr = "Kernel" }, { t("\\ker") }),
  s({ trig = "im", dscr = "Image" }, { t("\\operatorname{im}") }),
  s({ trig = "re", dscr = "Real part" }, { t("\\operatorname{Re}") }),
  s({ trig = "im", dscr = "Imaginary part" }, { t("\\operatorname{Im}") }),
  s({ trig = "gcd", dscr = "Greatest common divisor" }, { t("\\gcd") }),
  s({ trig = "lcm", dscr = "Least common multiple" }, { t("\\operatorname{lcm}") }),

  -- ACCENTS AND DECORATIONS
  s({ trig = "hat", dscr = "Hat accent" },
    fmta("\\hat{<>}", { d(1, get_visual) })
  ),
  s({ trig = "bar", dscr = "Bar accent" },
    fmta("\\bar{<>}", { d(1, get_visual) })
  ),
  s({ trig = "vec", dscr = "Vector arrow" },
    fmta("\\vec{<>}", { d(1, get_visual) })
  ),
  s({ trig = "tilde", dscr = "Tilde accent" },
    fmta("\\tilde{<>}", { d(1, get_visual) })
  ),
  s({ trig = "dot", dscr = "Dot accent" },
    fmta("\\dot{<>}", { d(1, get_visual) })
  ),
  s({ trig = "ddot", dscr = "Double dot accent" },
    fmta("\\ddot{<>}", { d(1, get_visual) })
  ),

  -- SPACING
  s({ trig = "quad"}, { t("\\quad") }),
  s({ trig = "qquad"}, { t("\\qquad") }),
}
