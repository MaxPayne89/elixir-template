%{
  configs: [
    %{
      name: "default",
      files: %{
        included: [
          "lib/",
          "test/"
        ]
      },
      strict: true,
      checks: [
        {Credo.Check.Design.TagTODO, false},
        {Credo.Check.Readability.ModuleDoc, []},
        {Credo.Check.Readability.MaxLineLength, [max_length: 100]},
        {Credo.Check.Consistency.TabsOrSpaces},
        {Credo.Check.Design.AliasUsage, [if_nested_deeper_than: 2]}
      ]
    }
  ]
}
