return {
-- Class
  s(
    "class",
    fmt(
      [[
extends []

func _ready() -> void:
	pass

func _process(_delta) -> void:
	pass
]],
      {
        i(1, "NodeType"),
      },
      {
        delimiters = "[]",
      }
    )
  ),
}, {
	s("autotrig", t("autotriggered, if enabled"))
}
