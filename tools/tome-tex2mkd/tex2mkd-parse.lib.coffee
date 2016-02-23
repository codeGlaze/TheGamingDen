do ->
  #end tex2md
  #start tex2md

  tex2md = ( str ) ->
    #start tex2md

    head = false
    chunks = ''
    bbcode = ''

    parse = ( str, delim ) ->
      str.split(delim)

    scanChunks  = ( len ) ->
      input = []
      ret = ""

      for n in [0..len-1]
        cn = chunks[n].trim()
        ###
        if !!cn then console.log "NULL! :: " + cn
        else if cn then console.log "Not null? :: " + cn
        else if cn == "\n" then console.log "newline :: " + cn
        else console.log "cn :: cd"
        ###
        console.log cn
        ret += if !!cn then formatStr( cn ) else "\n"
      return formatTxt( ret )

    formatTxt = ( str ) ->
      arr = parse( str, "\\")
      str = ""

      for n in [0..arr.length-1]
        str += arr[n].replace( /textit\{(.*)\}/i, "_$1_")
        .replace( /textbf\{(.*)\}/i, "**$1**")
        .replace( /emph\{(.*)\}/i, "**_$1_**" )
        .replace( /linkskill\{(.*)\}/i, "[$1](http://dnd-wiki.org/wiki/SRD:$1_Skill)" )
        .replace( /ldots\{\}/, "..." )
        .replace( /(?!.*\()\[(.*)\]/i, "[$1](http://dnd-wiki.org/wiki/SRD:$1)" )
      return str

    formatStr = ( str ) ->
      ret = ""
      sca = str.charAt(0)

      #if sca is "\\" and sca isnt "%"  #check first char of string for TeX slash
      if sca is "\\" #check first char of string for TeX slash

        matches = str.match(/(\w+)/i)
        found = matches[0]
        switch found
          when "raceentry"
            found = str.match(/{(.*)}/i)
            str = "## " + found[1] + "\n"
            ret += str
          when "tagline"  #capture the tagline, format then append to string
            found = str.match(/"(.*)"/i)
            str = "> " + found[1] + "\n"
            ret += str
          when "begin", "end", "classentry" #remove this string as unnecessary
            ret += ""
          when "item" #replace TeX with asterix
            #re = /\\item/i
            str = str.replace /\\item/i, "\n * "
            ret += str
          else  #append string as-is
            str += ":: ELSE!" + "\n"
            ret += str
      else if sca is "%" or not sca
        ret += ""
      else
        ret += "\n&emsp;&emsp;" + str #add any non-tex formatted strings, with indent in front
      # end

      #return formatTxt( ret )
      return ret

    init = ( str ) ->
      head = false
      chunks = parse( str, "\n" )
      #converted gets returned
      #converted = scanChunks( chunks.length ).trim()
      scanChunks( chunks.length ).trim()

    return init(str)
    #end tex2md
    return

  #return
  # { tex2md : tex2md }
  if not window.tex2md then window.tex2md = tex2md
  return
