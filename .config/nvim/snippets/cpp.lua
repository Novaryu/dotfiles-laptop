local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

return {
  ----------------------------------------------------------------------
  --                             Pointers                             --
  ----------------------------------------------------------------------
  -- https://en.cppreference.com/w/cpp/memory
  s("up", fmt([[std::unique_ptr<{}> {}]], { i(1, "type"), i(2, "name") })),
  s("sp", fmt([[std::shared_ptr<{}> {}]], { i(1, "type"), i(2, "name") })),
  s("wp", fmt([[std::weak_ptr<{}> {}]], { i(1, "type"), i(2, "name") })),

  ----------------------------------------------------------------------
  --                             Printing                             --
  ----------------------------------------------------------------------
  s("cout", fmt([[cout << "{}" << endl;]], { i(1, "somestuff") })),
  s("cin", fmt([[cin >> {};]], { i(1, "variable") })),

  ----------------------------------------------------------------------
  --                            Shorthands                            --
  ----------------------------------------------------------------------
  parse("c", "const"),
  s("sc", fmt("static_cast<{}>({})", { i(1, "type"), i(2, "var") })),
  s("sa", fmt("static_assert({}, {})", { i(1, "true == true"), i(2, [["true!"]]) })),
  parse("ca", "const auto"),
  s("ce", fmt("constexpr {} {} = {};", { i(1, "auto"), i(2, "name"), i(3, "1") })),

  s(
    "f",
    fmt("[] []([]) { [] };", { i(1, "int"), i(2, "newfunc"), i(3, "int i"), i(4, "") }, {
      delimiters = "[]",
    })
  ),

  ----------------------------------------------------------------------
  --                           preprocessor                           --
  ----------------------------------------------------------------------
  -- Arm neon detection
  s(
    "ifneon",
    fmt(
      [[#ifdef __ARM_NEON__
{}
#endif
		]],
      {
        i(1, "// ARM NEON Intrinsics here... "),
      }
    )
  ),

  s(
    "pragmamessage",
    fmt([[#pragma message("{}") ]], {
      i(1, "Hello!"),
    })
  ),

  ----------------------------------------------------------------------
  --                          STL Algorithms                          --
  ----------------------------------------------------------------------

  -- All of
  s(
    "allof",
    fmt([[std::all_of({}.cbegin(), {}.cend(), {});]], {
      i(1, "v"),
      rep(1),
      i(2, "[](int i){ return i % 2 == 0; }"),
    })
  ),

  -- Any of
  s(
    "anyof",
    fmt([[std::any_of({}.cbegin(), {}.cend(), {});]], {
      i(1, "v"),
      rep(1),
      i(2, [[[](int i){ return i % 2 == 0; }]]),
    })
  ),

  -- None of
  s(
    "noneof",
    fmt([[std::none_of({}.cbegin(), {}.cend(), {});]], {
      i(1, "v"),
      rep(1),
      i(2, "[](int i){ return i % 2 == 0; }"),
    })
  ),

  -- Find
  s(
    "find",
    fmt([[std::find(begin({}), end({}), {});]], {
      i(1, "v"),
      rep(1),
      i(2, "3"),
    })
  ),

  -- Find if
  s(
    "findif",
    fmt([[std::find_if(begin({}), end({}), {});]], {
      i(1, "v"),
      rep(1),
      i(2, "[](int i){ return i%2 == 0; }"),
    })
  ),

  -- For each
  s(
    "foreach",
    fmt([[std::for_each(begin({}), end({}), {});]], {
      i(1, "v"),
      rep(1),
      i(2, "[this](int& n) { printf(n); }"),
    })
  ),

  -- Transform
  s(
    "transform",
    fmt([[std::transform({}.cbegin(), {}.cend(), {}.begin(),  {});]], {
      i(1, "v"),
      rep(1),
      rep(1),
      i(2, "[](unsigned char c) { return std::toupper(c); }"),
    })
  ),

  -- Copy
  s(
    "copy",
    fmt([[std::copy({}.begin(), {}.end(), std::back_inserter({}));]], {
      i(1, "from_vector"),
      rep(1),
      i(2, "to_vector"),
    })
  ),

  -- Copy if
  s(
    "copyif",
    fmt([[std::copy_if({}.begin(), {}.end(), std::back_inserter({}), {});]], {
      i(1, "from_vector"),
      rep(1),
      i(2, "to_vector"),
      i(3, "[](int x) { return x % 3 == 0; }"),
    })
  ),

  -- Remove
  s(
    "remove",
    fmt([[std::remove({}.begin(), {}.end(), {});]], {
      i(1, "from_vector"),
      rep(1),
      i(2, "2"),
    })
  ),

  -- Remove if
  s(
    "removeif",
    fmt([[std::remove_if({}.begin(), {}.end(), {});]], {
      i(1, "myvector"),
      rep(1),
      i(2, "[](int x) { return x % 3 == 0; }"),
    })
  ),
  -- Iota
  s(
    "iota",
    fmt([[std::iota({}.begin(), {}.end(), {});]], {
      i(1, "myvector"),
      rep(1),
      i(2, "4"),
    })
  ),
  -- Reverse
  s(
    "reverse",
    fmt([[std::reverse({}.begin(), {}.end());]], {
      i(1, "myvector"),
      rep(1),
    })
  ),
  -- Sort
  s(
    "sort",
    fmt([[std::sort({}.begin(), {}.end());]], {
      i(1, "myvector"),
      rep(1),
    })
  ),
  -- Shuffle
  s(
    "shuffle",
    fmt(
      [[std::random_device rd;
std::mt19937 g(rd());
std::shuffle({}.begin(), {}.end(), {});]],
      {
        i(1, "myvector"),
        rep(1),
        i(2, "g"),
      }
    )
  ),
  -- Sample
  s(
    "sample",
    fmt(
      [[std::random_device rd;
std::mt19937 g(rd());
std::sample({}.begin(), {}.end(), {}, {}, {});]],
      {
        i(1, "myvector"),
        rep(1),
        i(2, "std::back_inserter(out)"),
        i(3, "numSamples"),
        i(4, "g"),
      }
    )
  ),

  -- Rotate
  s(
    "rotate",
    fmt([[std::rotate({}.begin(), {}.end() + {}, {}.end());]], {
      i(1, "myvector"),
      rep(1),
      i(2, "1"),
      rep(3),
    })
  ),

  -- TODO
  -- Equal
  -- Mismatch
  -- Previous permutation
  -- Next permutation
  -- Max element
  -- Min element
  -- Set_*
  -- Partial sort

  ----------------------------------------------------------------------
  --                         STL containers                           --
  ----------------------------------------------------------------------
  -- See all here: https://en.cppreference.com/w/cpp/container

  -- Map
  s(
    "map",
    fmt([[std::map<[], []> []{{[], []}, {[], []}};]], {
      i(1, "type"),
      i(2, "type"),
      i(3, "name"),
      i(4, "1"),
      i(5, "1"),
      i(6, "2"),
      i(7, "2"),
    }, { delimiters = "[]" })
  ),

  s(
    "unorderedmap",
    fmt([[std::unorderedmap<[], []> []{{[], []}, {[], []}};]], {
      i(1, "type"),
      i(2, "type"),
      i(3, "name"),
      i(4, "1"),
      i(5, "1"),
      i(6, "2"),
      i(7, "2"),
    }, { delimiters = "[]" })
  ),

  -- Array
  s(
    "arr",
    fmt("std::array<{}, {}> {} {};", {
      i(1, "type"),
      i(2, "3"),
      i(3, "name"),
      i(4, "= {}"),
    })
  ),

  -- Span
  s(
    "span",
    fmt("std::span<{}> {}({});", {
      i(1, "type"),
      i(2, "name"),
      i(3, "array"),
    })
  ),
  -- Vector
  s(
    "vec",
    fmt("std::vector<{}> {} {};", {
      i(1, "type"),
      i(2, "name"),
      i(3, "= {}"),
    })
  ),

  ----------------------------------------------------------------------
  --                            Functions                             --
  ----------------------------------------------------------------------

  -- Lambda
  s("lam", {
    t "[",
    i(1, "x"),
    t "]",
    t "(",
    i(2, "int y"),
    t ")",
    t " { ",
    i(3, "return x * y > 55;"),
    t " }",
  }),

  ----------------------------------------------------------------------
  --                        Control structures                        --
  ----------------------------------------------------------------------
  -- If else
  s(
    "ifelse",
    fmt(
      [[if([])
	{[]}
else
	{[]};]],
      {
        i(1, "condition"),
        i(2, "true"),
        i(3, "false"),
      },
      {
        delimiters = "[]",
      }
    )
  ),

-- Class Header
  s(
    "header",
    fmt(
      [[
#ifndef []_H
#define []_H

namespace []{

class [] {
private:
[]
public:
	[]();
	~[]();
};

} // namespace []
#endif
]],
      {

        i(1, "CLASS_NAME"),
        rep(1),

        i(2, "godot"),
        i(3, "ClassName"),
		c(4, {
			t({"protected:","static void _bind_methods();"}),
			t(""),
		}),
        rep(3),
        rep(3),
        rep(2),
      },
      {
        delimiters = "[]",
      }
    )
  ),

-- Class Body
  s(
    "class",
    fmt(
      [[
#include "[].h"

using namespace [];
[]
[]::[]() {}

[]::~[]() {}
]],
      {

        i(1, "class_name"),

        i(2, "godot"),
		c(3, {
			{t({"","void "}), i(1), t({"::_bind_methods() {}",""})},
			t(""),
		}),
        i(4, "ClassName"),
        rep(4),
        rep(4),
        rep(4),
      },
      {
        delimiters = "[]",
      }
    )
  ),

  ----------------------------------------------------------------------
  --                           Preprocessor                           --
  ----------------------------------------------------------------------

  -- #ifndef
  s(
    "ifndef",
    fmt(
      [[#pragma once
#ifndef {}
#define {}

#endif
		]],
      { i(1, "YO"), rep(1) }
    )
  ),

  ----------------------------------------------------------------------
  --                          Supercollider                           --
  ----------------------------------------------------------------------

  -- Supercollider specific stuff
  s("rtalloc", {
    t "(",
    i(1, "float"),
    t "*)RTAlloc(",
    i(2, "unit->mWorld"),
    t ",",
    i(3, "unit->bufsize"),
    t "* sizeof(",
    i(4, "float"),
    t ")",
  }),

  -- Smoothing control signals
  s(
    "slopeinit",
    fmt(
      "SlopeSignal<{}> {} = makeSlope(in0({}), {});",
      { i(1, "float"), i(2, "controlRateFreq"), i(3, "1"), i(4, "m_freq_past") }
    )
  ),

  s(
    "slopeconsume",
    fmt(
      [[const auto {} = {}.consume();
{} = {};
			]],
      { i(1, "freq"), i(2, "controlRateFreq"), i(3, "m_freq_past"), rep(1) }
    )
  ),

}
