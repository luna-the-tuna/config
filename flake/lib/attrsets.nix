{ lib, ... }:
{
  flake.lib.attrsets.imapAttrs1 =
    function: attrset:
    attrset
    |> lib.attrsToList
    |> lib.imap1 (index: entry: lib.nameValuePair entry.name (function index entry.name entry.value))
    |> lib.listToAttrs;
}
