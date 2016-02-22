(function() {
  var tex2md;
  tex2md = function(str) {
    var bbcode, chunks, formatStr, formatTxt, head, init, parse, scanChunks;
    head = false;
    chunks = '';
    bbcode = '';
    parse = function(str, delim) {
      return str.split(delim);
    };
    scanChunks = function(len) {
      var cn, i, input, n, ref, ret;
      input = [];
      ret = "";
      for (n = i = 0, ref = len - 1; 0 <= ref ? i <= ref : i >= ref; n = 0 <= ref ? ++i : --i) {
        cn = chunks[n].trim();

        /*
        if !!cn then console.log "NULL! :: " + cn
        else if cn then console.log "Not null? :: " + cn
        else if cn == "\n" then console.log "newline :: " + cn
        else console.log "cn :: cd"
         */
        console.log(cn);
        ret += !!cn ? formatStr(cn) : "\n";
      }
      return formatTxt(ret);
    };
    formatTxt = function(str) {
      var arr, i, n, ref;
      arr = parse(str, "\\");
      str = "";
      for (n = i = 0, ref = arr.length - 1; 0 <= ref ? i <= ref : i >= ref; n = 0 <= ref ? ++i : --i) {
        str += arr[n].replace(/textit\{(.*)\}/i, "_$1_").replace(/textbf\{(.*)\}/i, "**$1**").replace(/emph\{(.*)\}/i, "**_$1_**").replace(/linkskill\{(.*)\}/i, "[$1](http://dnd-wiki.org/wiki/SRD:$1_Skill)").replace(/ldots\{\}/, "...").replace(/(?!.*\()\[(.*)\]/i, "[$1](http://dnd-wiki.org/wiki/SRD:$1)");
      }
      return str;
    };
    formatStr = function(str) {
      var found, matches, ret, sca;
      ret = "";
      sca = str.charAt(0);
      if (sca === "\\") {
        matches = str.match(/(\w+)/i);
        found = matches[0];
        switch (found) {
          case "raceentry":
            found = str.match(/{(.*)}/i);
            str = "## " + found[1] + "\n";
            ret += str;
            break;
          case "tagline":
            found = str.match(/"(.*)"/i);
            str = "> " + found[1] + "\n";
            ret += str;
            break;
          case "begin":
          case "end":
          case "classentry":
            ret += "";
            break;
          case "item":
            str = str.replace(/\\item/i, "\n * ");
            ret += str;
            break;
          default:
            str += ":: ELSE!" + "\n";
            ret += str;
        }
      } else if (sca === "%" || !sca) {
        ret += "";
      } else {
        ret += "\n&emsp;&emsp;" + str;
      }
      return ret;
    };
    init = function(str) {
      head = false;
      chunks = parse(str, "\n");
      return scanChunks(chunks.length).trim();
    };
    return init(str);
  };
  return {
    tex2md: tex2md
  };
})();
