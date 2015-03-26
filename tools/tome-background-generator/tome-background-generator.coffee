formIn = 
  bkgd_name : ""
  bkgd_quote : ""
  bkgd_desc : ""
  bkgd_effect : ""

format = (id, str) ->
  if str == "" then str else
  
    switch id
      when "bkgd_name" then  "[b]"+str+":[/b] "
      when "bkgd_quote" then  "\"[i]"+str+"[/i]\" \n"
      when "bkgd_effect"  then  "\n[b]Effect:[/b] "+str+"\n"
      else str + "\n"
  
output = ( str ) ->
  # count number of lines from form
  numBreaks = (str.match(/\n/g)||[]).length
  
  $this = $("#output")
  # set height of textarea
  $this.val(str).height(numBreaks*21)
  return
  
go = ( id, str ) ->
  out = ''
  for k,v of formIn
    if id == k then formIn[k] = format id, str
    console.log "ID:: "+id+"FI: "+formIn[k]+" s: "+str
    if formIn[k]? and formIn[k] != ""
      out += formIn[k]

  return output out + "[hr]\n"

# trigger content refresh when textarea changes
#$(".form-control").on "change input paste keyup",
#_.throttle go $(@).val()

$("#left .form-control").on "change input paste keyup", ->
  go $(@).attr("id"), $(@).val()