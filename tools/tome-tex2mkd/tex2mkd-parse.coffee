#input to parse : TeX
#output type : markdown
head = false
chunks = ''
bbcode = ''

#set options for marked.js markdown editor
marked.setOptions =
  renderer: new marked.Renderer()
  gfm: true

#parse a string using the passed delimiter ( spaces, commas, etc... )
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

    #ret += "\n"
  #return ret
  return formatTxt( ret )

formatTxt = ( str ) ->
  arr = parse( str, "\\")
  str = ""

  console.log arr
  for n in [0..arr.length-1]
    console.log arr[n]
    #convert syntax for italics, bold, links, etc
    #Use gitbook.io styled reference links [Reference-Link][Display Text]
    #https://gitbookio.gitbooks.io/markdown/content/syntax/links.html
    ##NOTE## Switch to repository links?
    # !! [I'm a relative reference to a repository file](../blob/master/LICENSE) !!
    # format SRD links with HTML Codes	&#40; = ( , 	&#41; = )
    str += arr[n].replace( /textit\{(.*)\}/i, "_$1_").replace( /textbf\{(.*)\}/i, "**$1**").replace( /emph\{(.*)\}/i, "**_$1_**" ).replace( /linkskill\{(.*)\}/i, "[$1](http://dnd-wiki.org/wiki/SRD:$1_Skill)" ).replace( /ldots\{\}/, "..." ).replace( /(?!.*\()\[(.*)\]/i, "[$1](http://dnd-wiki.org/wiki/SRD:$1)" )
  return str

formatStr = ( str ) ->
  console.log "str::@@:: " + str
  ret = ""
  sca = str.charAt(0)
  console.log "SCA::@@::" + sca
  #if sca is "\\" and sca isnt "%"  #check first char of string for TeX slash
  if sca is "\\" #check first char of string for TeX slash
    console.log "match::@@:: " + str
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
    console.log "BLANKS! :::" + str
    ret += ""
  else
    console.log "OTHER! :::" + str
    ret += "\n&emsp;&emsp;" + str #add any non-tex formatted strings, with indent in front
  # end if
  #return formatTxt( ret )
  return ret

init = () ->
  head = false     # reset the header token
  # newlines into their own strings
  chunks = parse( $('#input').val(), "\n" )

  converted = scanChunks( chunks.length ).trim()
  console.log( converted )

  #$("#result").html(converted)
  $("#output").val(converted)
  $("#preview").html( marked(converted) )

init()

# trigger content refresh when textarea changes
$("#input").on "change input paste keyup", ->
  init()
  return
